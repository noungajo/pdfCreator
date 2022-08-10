# Comment envoyer un emails sur flutter

## Configuration de l'environement flutter pour envoyer un email

L'envoie d'un email via une application flutter peut se faire àl'aide du package *flutter_email_sender*. Pour utiliser ce package il doit être installé au projet via la commande :
> flutter pub add flutter_email_sender
> flutter pub get

Dans les téléphones donc le système est Android 11, il faut modifier le fichier *AndroidManifest.xml* suivant le code suivant :

```xml
<manifest package="com.companyname.appname">
  <queries>
    <intent>
      <action android:name="android.intent.action.SENDTO" />
      <data android:scheme="mailto" />
    </intent>
  </queries>
</manifest>
```
## Fonction pour envoyer un email

 Le package *flutter_email_sender* permet d'envoyer un email avec les caractéristique suivantes:
 - un objet
 - un corps de l'email
 - plusieurs récepteur
 - et l'option pour une pièce jointe à l'email


L'importation du package se fait via le code :

```dart
import 'package:flutter_email_sender/flutter_email_sender.dart';
```

Il est nécessaire d'avoir une interface qui contient les champs de l'email. Cela inclus une liste de destinataires, l'objet de l'email et le contenu de l'email, ainsi que la pièce jointe. A la fin, ajouter un bouton pour envoyer l'email.

voici la structure de toutes les données nécessaire pour envoyer un email. Le code est le suivant:

```dart
final Email send_email = Email(
  body: 'body of email',
  subject: 'subject of email',
  recipients: ['example1@ex.com'],
  cc: ['example_cc@ex.com'],
  bcc: ['example_bcc@ex.com'],
  attachmentPaths: ['/path/to/email_attachment.zip'],
  isHTML: false,
);

await FlutterEmailSender.send(send_email);
```