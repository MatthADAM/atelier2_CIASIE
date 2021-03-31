## Instalation

docker-compose up

## Liste des routes:

http://docketu.iutnc.univ-lorraine.fr:11503/api/user =>GET => Renvoie la liste complète des utilisateurs.

http://docketu.iutnc.univ-lorraine.fr:11503/api/user/:login  =>GET=>Renvoie l’utilisateur correspondant a :login. 

http://docketu.iutnc.univ-lorraine.fr:11503/api/userAdmin/:login  =>GET=>Renvoie  l’utilisateur admin correspondant a :login. 

http://docketu.iutnc.univ-lorraine.fr:11503/api/event (?public=...&owner=...) (?token=...) 
=>GET=>Renvoie la liste des événement il peut prendre en paramètre si il est public et un autre paramètre si on veut supprimer de la liste public ces propre événement, il peut prendre un autre paramètre le token cela permet de prendre seulement événement correspond au token.

http://docketu.iutnc.univ-lorraine.fr:11503/api/event/:id =>GET=> Renvoie l’événement correspond a :id.

http://docketu.iutnc.univ-lorraine.fr:11503/api/event/owner/:owner  =>GET=> Renvoie la liste des événement correspond a :owner (le créateur de l’événement)

http://docketu.iutnc.univ-lorraine.fr:11503/api/invitation =>GET=>Renvoie la liste complète des invitations. Il peut prendre en paramètre un event et un user ensemble ce qui permet de recevoir la liste des invitations faite par un utilisateur sur un événement.

http://docketu.iutnc.univ-lorraine.fr:11503/api/invitation/:event  =>GET=>Renvoie le liste des invitations correspondant a cette :event.

http://docketu.iutnc.univ-lorraine.fr:11503/api/invitation/user/:user =>GET=>Renvoie la liste des invitations envoyés par cet utilisateur(:user).

http://docketu.iutnc.univ-lorraine.fr:11503/api/comment =>GET=>Renvoie la liste des commentaires.

http://docketu.iutnc.univ-lorraine.fr:11503/api/comment/:id =>GET=>Renvoie le commentaire correspondant a l’id (:id).

http://docketu.iutnc.univ-lorraine.fr:11503/api/comment/owner/:owner =>GET=>Renvoie la liste des commentaire correspondant a l’utilisateur(:owner).

http://docketu.iutnc.univ-lorraine.fr:11503/api/comment/event/:event =>GET=>Renvoie la liste des commentaire correspondant a cette événement (:event).

http://docketu.iutnc.univ-lorraine.fr:11503/api/inscription=>POST=>Permet d’insérer un compte dans la base de données.

http://docketu.iutnc.univ-lorraine.fr:11503/api/inscriptionAdmin=>POST=>Permet d’insérer un compte administrateur dans la base de données. 

http://docketu.iutnc.univ-lorraine.fr:11503/api/updateUser=>POST=>Permet de mettre à jour les informations d’un utilisateur.

http://docketu.iutnc.univ-lorraine.fr:11503/api/updateUserAdmin=>POST=>Permet de mettre à jour les informations d’un utilisateur administrateur.

http://docketu.iutnc.univ-lorraine.fr:11503/api/addEvent=>POST=>Permet d’insérer un événement dans la base de données. 

http://docketu.iutnc.univ-lorraine.fr:11503/api/addInvitation=>POST=>Permet d’insérer une invitation dans la base de données. 

http://docketu.iutnc.univ-lorraine.fr:11503/api/addComment=>POST=>Permet d’insérer un commentaire dans la base de données. 

http://docketu.iutnc.univ-lorraine.fr:11503/api/UpdateStatus=>POST=>Permet de modifier le status d’une invitation

http://docketu.iutnc.univ-lorraine.fr:11503/api/delete/user/:login =>POST=>Permet de supprimer un utilisateur. :login est un login d’utilisateur

http://docketu.iutnc.univ-lorraine.fr:11503/api/delete/event/:id =>POST=>Permet de supprimer un événement. :event est un id d'événement

http://docketu.iutnc.univ-lorraine.fr:11503/api/delete/invitation/:event?user= =>POST=>Permet de supprimer une invitation. :event est un id d'événement et prends en paramètre un login