# KKamJi-Infra

Terraform을 통한 AWS Infra 프로비저닝

## AWS Infra Architecture

- [AWS Architecture](architecture/architecture.webp)

## 구축 완료 보고

- [x] S3, DynamoDB 백엔드 구성
- [x] ECR 생성
- [x] vpc 생성
- [x] EKS 생성
- [x] AWS Load Balancer Controller 배포
- [x] VPC CNI 접두사 할당
- [x] EKS Metrics Server 배포
- [x] EKS에 database, application 배포
- [x] karpenter 구성
- [x] Secrets Manager에 API 서버 환경변수 추가
- [x] Route53 LB 연동
- [x] LB TLS 인증
- [x] HPA 구성
- [x] ArgoCD 구성
- [x] Helm Chart 구성
- [x] WAF 구성
- [x] Monitoring -> CloudWatch Container Insight

## Helm Chart - helm-kkamji-app

```bash
cd helm-kkamji-app

helm install kkamji-app . -n helm-managed-kkamji-app --create-namespace \
  --set mysql.auth.username={user_name} \
  --set mysql.auth.password={user_password} \
  --set mysql.auth.database={database_name} \
  --set mysql.storage.storageClass={storageclass_name}

## mysql.storage.storageClass를 미지정 했을시 gp3라는 이름의 storage class가 존재해야함

❯ helm list -A
hNAME                           NAMESPACE                       REVISION        UPDATED                                 STATUS          CHART                                   APP VERSION
aws-load-balancer-controller    kube-system                     1               2024-11-02 02:47:53.310076158 +0900 KST deployed        aws-load-balancer-controller-1.9.2      v2.9.2     
karpenter                       karpenter                       1               2024-11-02 03:03:15.926017767 +0900 KST deployed        karpenter-1.0.7                         1.0.7      
kkamji-app                      helm-managed-kkamji-app         1               2024-11-02 05:10:48.26394829 +0900 KST  deployed        kkamji-app-0.1.0                        1.16.0     
```

##TODO ArgoCD 구성 이미지

##TODO Monitoring

##TODO WAF

##TODO 부하테스트 - karpenter 노드 프로비저닝 확인

## Secrets 관리

![alt text](docs/secret.png)

## 파일 디렉토리 구조

```bash
❯ tree
.
├── README.md
├── architecture
│   └── architecture.webp
├── helm-kkamji-app
│   ├── Chart.yaml
│   ├── charts
│   ├── templates
│   │   ├── _helpers.tpl
│   │   ├── helm-backend-deployment.yaml
│   │   ├── helm-backend-hpa.yaml
│   │   ├── helm-backend-secret.yaml
│   │   ├── helm-backend-service.yaml
│   │   ├── helm-mysql-configmap.yaml
│   │   ├── helm-mysql-initdb-configmap.yaml
│   │   ├── helm-mysql-pvc.yaml
│   │   ├── helm-mysql-secret.yaml
│   │   ├── helm-mysql-service.yaml
│   │   └── helm-mysql-statefulset.yaml
│   └── values.yaml
├── kubernetes
│   ├── argocd
│   │   └── argocd-ingress.yaml
│   ├── backend
│   │   ├── backend-deployment.yaml
│   │   ├── backend-hpa.yaml
│   │   ├── backend-ingress.yaml
│   │   └── backend-service.yaml
│   ├── database
│   │   ├── mysql-config-configmap.yaml
│   │   ├── mysql-initdb-configmap.yaml
│   │   ├── mysql-pvc.yaml
│   │   ├── mysql-secret.yaml
│   │   ├── mysql-statefulset.yaml
│   │   └── mysql-svc.yaml
│   ├── karpenter
│   │   ├── controller-policy.json
│   │   ├── controller-trust-policy.json
│   │   ├── iam_policy.json
│   │   ├── node-pool.yaml
│   │   └── node-trust-policy.json
│   ├── storage_class
│   │   └── gp3-storage_class.yaml
│   └── test
│       ├── al2.yaml
│       ├── karpenter.yaml
│       └── test-pod.yaml
├── terraform
│   ├── main.tf
│   ├── modules
│   │   ├── ecr
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── eks
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam_policy
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam_role
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── vpc
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── waf
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── outputs.tf
│   ├── prod
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── templates
│   │   ├── backend_pod_policy.json
│   │   ├── controller-policy.json
│   │   ├── controller-trust-policy.json
│   │   ├── lb_controller_policy.json
│   │   ├── node-trust-policy.json
│   │   └── user_data.sh
│   ├── terraform.tfstate
│   └── versions.tf
```

