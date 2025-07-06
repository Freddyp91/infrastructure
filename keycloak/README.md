# Keycloak Blue/Green Deployment

This directory contains the Kubernetes manifests for deploying Keycloak using ArgoCD Rollouts for blue/green deployments.

## Files

- `namespace.yaml` - Creates the keycloak namespace
- `service.yaml` - Active service that routes traffic to the current version
- `preview-service.yaml` - Preview service for testing new versions
- `rollout.yaml` - Argo Rollouts configuration for blue/green deployment
- `analysis-template.yaml` - Analysis template for automated promotion decisions
- `argocd-application.yaml` - ArgoCD application configuration
- `kustomization.yaml` - Kustomize configuration
- `deployment-blue.yaml` - Blue deployment (Keycloak v23.0.7)
- `deployment-green.yaml` - Green deployment (Keycloak v24.0.2)

## Deployment Process

1. **Initial Deployment (Blue)**:
   ```bash
   kubectl apply -f argocd-application.yaml
   ```

2. **Upgrade to Green**:
   - Update the image tag in `rollout.yaml`
   - ArgoCD will automatically sync and create a new rollout
   - Monitor the rollout status:
     ```bash
     kubectl argo rollouts get rollout keycloak-rollout -n keycloak
     ```

3. **Promote the deployment**:
   ```bash
   kubectl argo rollouts promote keycloak-rollout -n keycloak
   ```

## Blue/Green Strategy

The blue/green deployment strategy:
- Maintains two identical production environments
- Only one serves live traffic at a time
- Provides instant rollback capabilities
- Reduces downtime during deployments

## Versions

- **Blue**: Keycloak v23.0.7
- **Green**: Keycloak v24.0.2

## Access

Once deployed, Keycloak will be accessible via the LoadBalancer service.
Default credentials: admin/admin123