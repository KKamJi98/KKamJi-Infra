# KKamJi-Infra

Terraform을 통한 AWS Infra 프로비저닝

## AWS Infra Architecture

- [AWS Architecture](architecture/architecture.png)

## Internal EKS Architecture

## TODO List

- [x] S3, DynamoDB 백엔드 구성
- [x] ECR 생성
- [x] vpc 생성
- [x] EKS 생성
- [x] EKS에 database, application 배포
- [x] AWS Load Balancer Controller 배포
- [x] EKS Metrics Server 배포
- [x] Secrets Manager에 API 서버 환경변수 추가
- [x] Route53 LB 연동
- [x] LB TLS 인증
- [x] karpenter 세팅
- [x] HPA 세팅
- [ ] WAF 세팅
- [ ] Helm Chart 구성
- [ ] 

## Hope

base64 인코딩 할 때 무조건 -n 옵션을 붙혀 개행문자 없애기
