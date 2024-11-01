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

## 파일 디렉토리 구조