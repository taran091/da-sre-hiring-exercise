#!/bin/bash
test_name="hiring-test-$(whoami).txt"

echo -e "### GIT PATCH ###\n" > ${test_name}
git format-patch --stdout $(git rev-list --max-parents=0 HEAD)..HEAD >> ${test_name} 2>&1

echo -e "\n\n### K8S GET RESOURCES FOR MINIKUBE ###\n" >> ${test_name}
kubectl get pods,services,deployments,configmaps,secrets,pv,pvc,ingresses >> ${test_name} 2>&1

echo -e "\n\n### K8S DESCRIBE RESOURCES FOR MINIKUBE ###\n" >> ${test_name}
kubectl describe pods,services,deployments,configmaps,secrets,pv,pvc,ingresses >> ${test_name} 2>&1

echo -e "\n\n### CONVERSION_RATE METRIC ###\n" >> ${test_name}
curl -sG http://localhost:8080/api/v1/query --data-urlencode "query=conversion_rate" >> ${test_name} 2>&1

echo -e "\n\n### RANDO METRIC ###\n" >> ${test_name}
curl -sG http://localhost:8080/api/v1/query --data-urlencode "query=node_boot_time_seconds" >> ${test_name} 2>&1

echo -e "\n\n### CURL GET ENDPOINT WITH NOTHING ###\n" >> ${test_name}
curl -sG http://localhost:8000/ >> ${test_name} 2>&1

echo -e "\n\n### CURL DATE ENDPOINT WITH DATE IN 2023 ###\n" >> ${test_name}
curl -sG http://localhost:8000/date/1688169600 >> ${test_name} 2>&1

echo -e "\n\n### CURL DATE ENDPOINT WITH DATE IN 2010 ###\n" >> ${test_name}
curl -sG http://localhost:8000/date/1262347200 >> ${test_name} 2>&1

echo -e "\n\n### CURL POST ENDPOINT 1 ###\n" >> ${test_name}
curl -s -H "Content-Type: application/json" -X POST "http://localhost:8000/" -d '{"date":"1719878399","from_currency":"UAH","to_currency":"USD","amount":"80"}' >> ${test_name} 2>&1

echo -e "\n\n### CURL POST ENDPOINT 2 ###\n" >> ${test_name}
curl -s -H "Content-Type: application/json" -X POST "http://localhost:8000/"  -d '{"date":"962467200","from_currency":"UAH","to_currency":"USD","amount":"80"}' >> ${test_name} 2>&1

echo -e "\n\n### CURL POST ENDPOINT 3 ###\n" >> ${test_name}
curl -s -H "Content-Type: application/json" -X POST "http://localhost:8000/" -d '{"date":"962467200","from_currency":"USD","to_currency":"UAH","amount":"0.25"}' >> ${test_name} 2>&1

echo 'Thank you for completing our hiring test!'
echo
echo "Please send your results (${test_name}) to da-sre-hiring-exercise@wix.com for us to review"
