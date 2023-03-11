---
repoServer:
  deploymentAnnotations:
    reloader.stakater.com/auto: "true"

  initContainers:
    - name: plugin-setup
      image: ubuntu
      command:
        - sh
        - -c
        - |
            apt-get update && apt-get install -y ca-certificates wget
            wget -q https://get.helm.sh/helm-v${plugin_versions["helm"]}-linux-amd64.tar.gz -O - | tar xz && mv linux-amd64/helm /tools/helm && chmod +x /tools/helm
            wget -q https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${plugin_versions["kustomize"]}/kustomize_v${plugin_versions["kustomize"]}_linux_amd64.tar.gz -O - | tar xz && mv kustomize /tools/kustomize && chmod a+x /tools/kustomize
            wget -q https://github.com/stedolan/jq/releases/download/jq-${plugin_versions["jq"]}/jq-linux64 -O /tools/jq && chmod +x /tools/jq
            wget -q https://github.com/mikefarah/yq/releases/download/v${plugin_versions["yq"]}/yq_linux_amd64 -O /tools/yq && chmod +x /tools/yq
            wget -q https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${plugin_versions["argo-vault-plugin"]}/argocd-vault-plugin_${plugin_versions["argo-vault-plugin"]}_linux_amd64 -O /tools/argocd-vault-plugin && chmod +x /tools/argocd-vault-plugin
      volumeMounts:
        - mountPath: /etc/ssl
          name: ssl-files
        - mountPath: /tools
          name: plugin-tools

  extraContainers:
%{ for name, spec in plugins ~}
    - name: plugin-${name}
      command: [/var/run/argocd/argocd-cmp-server]
      args: [--loglevel, debug]
      image: ubuntu
      env:
        - name: AVP_TYPE
          value: sops
        - name: SOPS_AGE_KEY_FILE
          value: /age/key.txt
        - name: HELM_CACHE_HOME
          value: /helm-working-dir
        - name: HELM_CONFIG_HOME
          value: /helm-working-dir
        - name: HELM_DATA_HOME
          value: /helm-working-dir
      securityContext:
        runAsNonRoot: true
        runAsUser: 999
      volumeMounts:
        - mountPath: /age
          name: argocd-vault-plugin-age-key
        - mountPath: /var/run/argocd
          name: var-files
        - mountPath: /etc/ssl
          name: ssl-files
        - mountPath: /home/argocd/cmp-server/plugins
          name: plugins
        - mountPath: /helm-working-dir
          name: plugin-tmp
        - mountPath: /home/argocd/cmp-server/config/plugin.yaml
          subPath: plugin.yaml
          name: argocd-plugin-${name}
        - mountPath: /usr/local/bin
          name: plugin-tools
%{ for file in spec.files ~}
        - mountPath: /var/run/argocd/plugin/${file}
          subPath: ${file}
          name: argocd-plugin-${name}
%{ endfor ~}
%{ endfor ~}
   
  volumes:
%{ for name, spec in plugins ~}
    - configMap:
        name: argocd-plugin-${name}
      name: argocd-plugin-${name}
%{ endfor ~}
    - secret:
        secretName: argocd-vault-plugin-age-key
      name: argocd-vault-plugin-age-key
    - emptyDir: {}
      name: ssl-files
    - emptyDir: {}
      name: plugin-tmp
    - emptyDir: {}
      name: plugin-tools
