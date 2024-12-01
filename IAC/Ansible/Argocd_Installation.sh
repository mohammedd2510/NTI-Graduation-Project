#!/usr/bin/bash
aws eks update-kubeconfig --region us-east-1 --name eks-cluster
kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd -n argocd argo/argo-cd
kubectl port-forward service/argocd-server -n argocd 8080:443 &
argocd login localhost:8080 --username admin --password $(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d) --insecure
kubectl apply -f ../Argocd/argo-cd.yaml
