.PHONY: deploy-dadjokes verify-dadjokes

deploy-dadjokes:
	kubectl apply -f namespace.yaml 
	helm install sre-techtask ./sre-techtask -n sre-techtask

verify-dadjokes:
	@echo "Verifying deployment..."
	kubectl get pods -n sre-techtask
	kubectl get svc -n sre-techtask
	kubectl get ingress -n sre-techtask
	curl http://dadjokes.local

