
helm inspect values stable/jenkins > ./jenkins.values

helm install jenkins stable/jenkins -f jenkins.values

helm upgrade jenkins stable/jenkins -f jenkins.values

1. Get your 'admin' user password by running:
  printf $(kubectl get secret --namespace default jenkins-blue -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=delivery" -o jsonpath="{.items[0].metadata.name}")
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward $POD_NAME 8080:8080

3. Login with the password from step 1 and the username: admin