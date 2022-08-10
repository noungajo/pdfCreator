# Sélection de la méthode de paiement
 Dans le tunel de paiement, l'utilisateur est appelé à choisir une méthode de paiement. Cela se fait via le endpoint *PATCH /api/v2/shop/orders/{tokenValue}/payments/{paymentId}* . En paramètre il faut ajouter le token de la commande et l'id de la méthode de paiement (paymentId) choisit. 
 Le paymentId s'obtient via le endpoint *GET /api/v2/shop/payment-methods/{code}* . En paramètre il faut ajouter le code de la méthode de paiement dont on aimerait avoir les ressources. Ainsi pour la méthode de paiement *mtn_momo* on aura le json suivant :

 ```json
{
  "@context": "/api/v2/contexts/PaymentMethod",
  "@id": "/api/v2/shop/payment-methods/mtn_momo",
  "@type": "PaymentMethod",
  "id": 3,
  "code": "mtn_momo",
  "position": 2,
  "name": "MTN Mobile Money",
  "description": "Possimus beatae quis eum exercitationem necessitatibus.",
  "instructions": null
}
 ```

Ainsi fait, nous avons l'id de la méthode de paiement. Il est maintenant possible de l'ajouter comme mode de paiement au panier. via le endpoint *PATCH /api/v2/shop/orders/{tokenValue}/payments/{paymentId}* expliqué précédemment.
la requête est la suivante:
```shell
curl -X 'PATCH' \
  'http://163.172.48.36:8081/api/v2/shop/orders/GmTTOxXMdT/payments/3' \
  -H 'accept: application/ld+json' \
  -H 'Content-Type: application/merge-patch+json' \
  -d '{
  "paymentMethod": "mtn_momo"
}'
```

Le résultat de cette requête donne:

```json
{
  "code": 500,
  "message": "No resource associated to \"mtn_momo\"."
}
```

# Sélection du mode de livraison

 Dans le tunel de paiement, l'utilisateur est appelé à choisir une méthode de livraison. Cela se fait via le endpoint *PATCH /api/v2/shop/orders/{tokenValue}/shipments/{shipmentId}* . En paramètre il faut ajouter le token de la commande et l'id de la méthode de livraison (shipmentId) choisit. 
 Le shipmentId s'obtient via le endpoint *GET /api/v2/shop/shipping-methods/{code}* . En paramètre il faut ajouter le code de la méthode de livraison dont on aimerait avoir les ressources. Ainsi pour la méthode de livraison *home* on a le json suivant :

 ```json
{
  "@context": "/api/v2/contexts/ShippingMethod",
  "@id": "/api/v2/shop/shipping-methods/home",
  "@type": "ShippingMethod",
  "id": 1,
  "code": "home",
  "position": 0,
  "name": "Domicile",
  "description": "Eum optio pariatur quo pariatur ut iure."
}
 ```

Ainsi fait, nous avons l'id de la méthode de livraison. Il est maintenant possible de l'ajouter comme mode de livraison au panier. via le endpoint *PATCH /api/v2/shop/orders/{tokenValue}/shipments/{shipmentId}* expliqué précédemment.
la requête est la suivante:
```shell
curl -X 'PATCH' \
  'http://163.172.48.36:8081/api/v2/shop/orders/GmTTOxXMdT/shipments/1' \
  -H 'accept: application/ld+json' \
  -H 'Content-Type: application/merge-patch+json' \
  -d '{
  "shippingMethod": "home"
}'
```

Le résultat de cette requête donne:

```json
{
  "code": 500,
  "message": "No resource associated to \"home\"."
}
```