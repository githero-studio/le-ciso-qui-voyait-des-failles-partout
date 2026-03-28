#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

# Init repo if needed
if [ ! -d ".git" ]; then
    git init
    git checkout -b main
fi

git add -A
git commit -m "init: book metadata"

# ============================================================================
# MAIN : Le parcours du CISO
# ============================================================================

# --- MAIN COMMIT 1 ---
git commit --allow-empty -m "Premier jour, premier audit, première sueur froide

Tu franchis la porte de NexaFlow un lundi matin de janvier. L'open space sent le café froid et l'ambition débridée. Le CEO, Thomas, t'accueille avec un grand sourire : \"Ah, notre nouveau CISO ! On est super contents. Tu vas voir, on a déjà une bonne base sécu.\" Tu souris poliment. Tu sais que cette phrase est l'équivalent corporate de \"on n'a absolument rien fait\".

Ton premier réflexe professionnel : demander l'inventaire des assets. Romain, le CTO, te regarde comme si tu venais de lui parler en klingon. \"Un inventaire ? Genre... une liste ?\" Tu ouvres ton laptop, tu lances un scan réseau basique. 347 machines répondent. L'organigramme IT en liste 180. Tu sens ton ulcère qui dit bonjour. Sur le wiki interne (un Notion que personne ne maintient), tu trouves un document intitulé \"Architecture technique\" qui date de 2020 et contient un seul schéma fait sur draw.io avec trois boîtes et une flèche. La flèche est étiquetée \"magie\"."

# --- MAIN COMMIT 2 ---
git commit --allow-empty -m "L'audit des mots de passe révèle l'ampleur du désastre — et un choix se pose

Tu demandes à Stéphane, l'admin sys historique qui est là depuis le garage, de te montrer la politique de mots de passe. Il te regarde avec la sérénité d'un homme qui n'a jamais eu besoin de politique. \"Les gens choisissent ce qu'ils veulent, c'est des adultes.\" Tu insistes. Il t'ouvre un fichier Excel sur un NAS partagé. Le fichier s'appelle \"mdp_prod_FINAL_v3_copie.xlsx\". Il contient les identifiants de tous les services critiques. En clair. Sans protection. Le mot de passe root de la production est \"Startup2021!\". Le mot de passe de la base de données est \"NexaFlow123\". Le mot de passe du compte AWS root est \"thomas1234\" — le prénom du CEO suivi de son année de naissance.

Tu vérifies le channel Slack #infra. Le mot de passe de la prod y a été partagé 14 fois en 6 mois. Maxence, le stagiaire arrivé il y a deux semaines, a les accès admin à tout. Pourquoi ? \"Parce qu'il avait besoin d'un truc et c'était plus simple.\" Tu refermes ton laptop. Tu le rouvres. Le cauchemar est toujours là.

Tu es face à un carrefour : l'ampleur du désastre est telle que tu pourrais passer des mois à colmater les brèches une par une, de l'intérieur, avec ta propre expertise. Mais il y a une autre voie : faire appel à une équipe de pentest externe, des hackers éthiques, pour cartographier la surface d'attaque de manière objective et brutale. L'avantage ? Un rapport choc qui mettrait tout le monde face à la réalité. Le risque ? Que le résultat soit si catastrophique que Thomas décide de tuer le projet sécu avant même qu'il commence."

DIVERGE_POINT_1=$(git rev-parse HEAD)

# --- MAIN COMMIT 3 ---
git commit --allow-empty -m "Le shadow IT révèle une hémorragie de données — la prochaine fuite est une question d'heures

Tu décides de cartographier les outils utilisés par l'entreprise. Le département IT officiel gère Google Workspace, AWS, et un Jira que personne n'utilise parce que \"c'est trop compliqué\". Tu lances une analyse des flux DNS et des dépenses par carte bancaire corporate. Le résultat te glace le sang : 153 outils SaaS différents sont utilisés par les équipes. 153. Les commerciaux ont leur propre CRM (en plus de celui de l'entreprise). Le marketing utilise 7 outils de design différents. Quelqu'un au support a connecté un outil chinois de traduction automatique à la base de tickets clients. Les données clients transitent par un serveur à Shenzhen.

Julie, la dev senior, utilise un outil de snippets de code en ligne où elle stocke des \"bouts de config utiles\". Tu jettes un oeil. Il y a des tokens d'API, des chaînes de connexion à la BDD, et un fichier intitulé \"secrets_prod.env\". L'outil est en plan gratuit. Le profil de Julie est public.

Tu sens une urgence viscérale. Ces données sont à poil sur Internet, là, maintenant, pendant que tu lis ce fichier. Des dumps clients sur des SaaS inconnus, des secrets sur des profils publics, des flux vers la Chine sans aucun DPA. N'importe quel acteur malveillant avec un moteur de recherche pourrait tomber dessus. La question n'est pas \"est-ce qu'il y aura une fuite\" mais \"est-ce qu'elle a déjà eu lieu sans qu'on le sache\". Et tu n'as aucun moyen de le vérifier — pas de DLP, pas de monitoring des données sortantes, rien. Tu es assis sur une bombe à retardement dont tu ne connais ni le timer ni la charge."

DIVERGE_POINT_2=$(git rev-parse HEAD)

# --- MAIN COMMIT 4 ---
git commit --allow-empty -m "Le MFA est imposé, mais la victoire a un goût amer — l'architecture est une passoire

Tu annonces en réunion plénière que le MFA (Multi-Factor Authentication) sera obligatoire sur tous les outils à partir de lundi prochain. Le silence qui suit est celui qui précède les émeutes. Romain lève la main : \"C'est quoi le MFA déjà ?\" Tu expliques. Thomas, le CEO, fronce les sourcils : \"Mais moi j'accède à mes mails depuis mon iPad, mon iPhone, et le PC de ma femme. Ça va marcher partout ?\" Un commercial au fond de la salle lève la main : \"Et si on perd son téléphone ?\" Stéphane grommelle : \"Moi mes serveurs ils ont pas de téléphone.\"

Le lundi arrive. Tu actives le MFA sur Google Workspace. En 45 minutes, tu reçois 67 tickets de support. Le CEO s'est bloqué lui-même hors de son compte. Le directeur commercial hurle qu'il va \"perdre le deal du siècle\". Maxence a noté son code de récupération MFA sur un post-it collé sur son écran.

Après deux semaines de chaos, le MFA finit par être accepté. Mais cette victoire te laisse un goût de cendres. Le MFA protège les portes d'entrée, d'accord. Mais derrière ces portes, l'architecture est un gruyère. Pas de segmentation réseau. Les microservices communiquent en clair sur le réseau interne. Un seul token compromis donne accès à tout. Le MFA, c'est un verrou blindé sur une porte en carton. Tu le sais. Et une voix dans ta tête murmure : \"Il faudrait tout reprendre à zéro. Zero Trust. Ne faire confiance à rien ni personne.\" Mais Thomas veut aller vite, les devs veulent livrer des features, et un projet Zero Trust pourrait paralyser la boîte pendant des semaines. La tentation est là, le risque aussi."

DIVERGE_POINT_3=$(git rev-parse HEAD)

# --- MAIN COMMIT 5 ---
git commit --allow-empty -m "La politique de mots de passe déclenche une révolte — la sécurité est un problème humain, pas technique

Fort de l'élan du MFA (qui a fini par être accepté après deux semaines de mutinerie douce), tu décides d'attaquer les mots de passe. Ta nouvelle politique : 24 caractères minimum, mélange de majuscules, minuscules, chiffres et caractères spéciaux, rotation mensuelle, interdiction de réutiliser les 12 derniers mots de passe. Tu la présentes comme \"les bonnes pratiques de l'industrie\". Romain te répond que \"l'industrie\" ne gère pas une scale-up qui doit livrer des features tous les deux jours.

Le résultat est instantané : 40% des employés utilisent maintenant des post-its collés sous leur clavier. Les 60% restants utilisent des variations de \"NexaFlow\" suivi du mois en cours. Un dev a écrit un script qui génère des mots de passe conformes et les stocke dans un fichier .txt sur son bureau. Amira, la DPO, vient te voir pour te dire que trois employés ont déposé une plainte informelle. Thomas te demande si \"on ne pourrait pas assouplir un peu, juste pour les managers\".

Tu réalises quelque chose de fondamental : tu as gagné toutes les batailles techniques et tu es en train de perdre la guerre culturelle. Les gens ne contournent pas la sécurité par malice — ils la contournent parce qu'elle leur rend la vie impossible. Tu ne peux pas sécuriser une entreprise contre ses propres employés. Il faudrait des alliés à l'intérieur, des relais dans chaque équipe, des gens qui portent le message sécu parce qu'ils y croient, pas parce que tu les y forces. Mais comment créer ces alliés quand tout le monde te voit comme l'ennemi ?"

DIVERGE_POINT_4=$(git rev-parse HEAD)

# --- MAIN COMMIT 6 ---
git commit --allow-empty -m "La campagne de phishing simulé révèle une vulnérabilité humaine béante — et personne ne sait quoi en faire

Tu organises la première campagne de sensibilisation au phishing. Tu prépares un faux mail qui imite une notification LinkedIn : \"Quelqu'un a consulté votre profil 47 fois cette semaine.\" C'est grossier, bourré de fautes, avec un lien qui pointe vers \"linkedln.com\" (avec un L minuscule à la place du i). Tu l'envoies à toute l'entreprise un mardi à 14h. En 30 minutes, 43% des employés ont cliqué. En 1 heure, 28% ont entré leurs identifiants.

Le CEO a cliqué dans les 90 premières secondes. Il a entré son mot de passe. Puis il a reçu une erreur. Alors il a réessayé. Avec son mot de passe personnel cette fois. Thomas utilise le même mot de passe pour LinkedIn et pour son compte AWS root. Tu présentes les résultats en comité de direction. Thomas rit nerveusement : \"Ah oui mais moi c'était pour tester, je savais que c'était faux.\" Seule Amira semble comprendre la gravité.

Le résultat est sans appel : 43% de clic sur un phishing grossier. Contre un vrai phishing ciblé, le taux serait probablement de 70%. Tu es assis sur une entreprise où n'importe quel mail bien ficelé peut donner un accès total à un attaquant. Et maintenant ? Deux chemins s'ouvrent devant toi. Tu pourrais intensifier les campagnes simulées, monter en sophistication, forger des réflexes à force de répétition — quitte à passer pour le harceleur en chef de l'entreprise. Ou tu pourrais te concentrer sur les contrôles techniques : DMARC, filtrage, double validation des virements — accepter que les humains cliqueront toujours et bâtir un filet de sécurité en dessous. Mais pendant que tu réfléchis, quelque part, un vrai phishing est peut-être déjà en train d'atterrir dans une boîte mail de NexaFlow."

DIVERGE_POINT_5=$(git rev-parse HEAD)

# --- MAIN COMMIT 7 ---
git commit --allow-empty -m "Les secrets dans le code, ou la piñata de clés API — l'équipe est dépassée et tu ne peux pas tout auditer seul

Tu demandes à l'équipe dev de te montrer leur gestion des secrets. Romain te donne accès au monorepo GitHub. Tu lances un scan avec truffleHog. Le résultat : 247 secrets détectés dans l'historique git. Des clés API AWS, des tokens Stripe, des mots de passe de bases de données, un token Slack de bot avec des permissions admin, et — cerise sur le gâteau — la clé privée SSL du domaine principal, commitée en 2021 par Julie avec le message \"temp: ajout clé pour debug, À SUPPRIMER\". Elle n'a jamais été supprimée.

Tu convoques une réunion d'urgence avec les devs. Tu expliques le concept de vault, de variables d'environnement, de rotation de secrets. Un dev junior lève la main : \"Mais si c'est dans les variables d'environnement, comment je fais pour les partager avec l'équipe ?\" Un autre dev : \"On peut les mettre dans un channel Slack privé ?\" Le .env de production est versionné dans le repo depuis le premier commit. Le .gitignore ne contient que node_modules et .DS_Store. Thomas te demande si \"un Google Doc protégé par un mot de passe\" ne ferait pas l'affaire.

247 secrets. Dans l'historique Git. Même si tu nettoies le présent, le passé est indexé, forké, caché dans des caches de moteurs de recherche. Tu n'as pas les bras pour tout auditer, tout révoquer, tout migrer. L'équipe dev est déjà sous l'eau avec les features. Tu pourrais tout verrouiller en interne, mettre des mois à assainir — mais pendant ce temps, chaque secret exposé est une porte ouverte. L'alternative te trotte dans la tête : et si tu ouvrais les portes volontairement ? Un programme de bug bounty, des hackers éthiques payés pour trouver ce que tu n'as pas le temps de chercher. C'est un pari : inviter des étrangers à fouiller dans ton infrastructure trouée. Mais l'alternative — attendre que les mauvais trouvent avant toi — est pire."

DIVERGE_POINT_6=$(git rev-parse HEAD)

# --- MAIN COMMIT 8 ---
git commit --allow-empty -m "Le VPN obligatoire tourne au fiasco — tu es aveugle sans visibilité sur ce qui se passe réellement

Tu mets en place un VPN obligatoire pour accéder aux ressources internes. Le choix s'est porté sur une solution open source (budget oblige, Thomas a refusé de payer pour \"un tunnel\"). L'installation se passe bien. Pendant exactement 47 minutes. Puis les déconnexions commencent. Le VPN coupe toutes les 45 minutes. Les devs perdent leurs sessions SSH. Les commerciaux perdent leurs appels Zoom en plein milieu de démos clients. Stéphane refuse catégoriquement de l'utiliser : \"Moi je suis sur le réseau local, j'en ai pas besoin.\" Tu lui expliques que le réseau local n'existe plus depuis qu'on est passé au cloud. Il te regarde avec l'incompréhension d'un homme dont on vient de nier l'existence du soleil.

Après deux semaines de plaintes, tu découvres que le serveur VPN tourne sur une instance t2.micro chez AWS (la plus petite possible) parce que Romain a \"optimisé les coûts d'infra\". Tu demandes un upgrade. Thomas te demande de \"prouver le ROI du VPN\".

Mais le VPN n'est qu'un symptôme d'un problème plus profond : tu n'as aucune visibilité. Les connexions entrent et sortent, les données circulent, les utilisateurs se connectent depuis n'importe où — et tu ne vois rien. Pas de logs centralisés, pas de corrélation d'événements, pas d'alertes. Si quelqu'un est en train de siphonner la base de données en ce moment, tu ne le saurais pas. Le VPN te donne un tunnel, mais un tunnel sans caméra c'est juste un couloir sombre. Tu as besoin d'yeux — un SIEM, un système qui collecte tout, corrèle tout, et te réveille quand quelque chose cloche. Mais c'est un projet monstre, coûteux, et Thomas ne comprend même pas pourquoi il faudrait payer pour \"lire des logs\"."

DIVERGE_POINT_7=$(git rev-parse HEAD)

# --- MAIN COMMIT 9 ---
git commit --allow-empty -m "La compliance RGPD révèle un problème qui dépasse la technique — c'est la culture qu'il faut changer

Amira débarque à ton bureau un matin avec un café et un air grave. Un client a exercé son droit d'accès RGPD : il veut savoir quelles données NexaFlow détient sur lui. Simple, non ? Non. Les données clients sont réparties sur 7 bases de données différentes, 3 outils SaaS, un Google Sheet que le support utilise pour \"les cas spéciaux\", et un backup Mongo qui tourne sur le Mac mini sous le bureau de Stéphane (\"c'est pour les urgences\"). Personne ne sait exactement quelles données sont collectées. Il n'y a pas de registre de traitement. Le bandeau cookies du site web propose \"Accepter\" ou \"Accepter tout\" — il n'y a pas de bouton refuser.

Tu organises un atelier de cartographie des données avec toutes les équipes. Les commerciaux admettent exporter les contacts clients vers leur Gmail personnel \"pour travailler le week-end\". Le marketing a uploadé la base client sur un outil d'enrichissement de données basé aux États-Unis, sans DPA. Le support technique a un Google Form public où les clients laissent leurs infos — les résultats sont visibles par \"toute personne ayant le lien\". Amira commence à hyperventiler.

Et toi, tu vois plus loin que la RGPD. Ce que cet exercice révèle, c'est que le problème n'est pas technique — il est culturel. Les données fuient parce que personne ne pense à la sécurité, personne ne pense à la vie privée, personne ne pense aux conséquences. Tu peux patcher les outils, tu peux écrire des politiques, tu peux mettre des contrôles — mais tant que la culture ne change pas, les gens trouveront toujours un moyen de contourner. La question est brutale : est-ce que tu continues à colmater les fuites une par une, à jouer au pompier éternel ? Ou est-ce que tu tentes le vrai changement — intégrer la sécurité dans le processus de développement lui-même, transformer la façon dont les gens pensent et codent ? C'est plus long, plus dur, et si ça échoue, tu auras perdu des mois sans avoir rien protégé."

DIVERGE_POINT_8=$(git rev-parse HEAD)

# --- MAIN COMMIT 10 ---
git commit --allow-empty -m "La tentative ISO 27001 ouvre une boîte de Pandore — la normalisation contre la survie

Après six mois de lutte, tu proposes à Thomas de viser la certification ISO 27001. C'est le Graal : ça rassure les clients enterprise, ça structure la sécu, et ça te donne enfin un cadre que tu peux brandir quand les gens te disent \"mais pourquoi ?\". Thomas est enthousiaste : \"Super, on fait ça en combien de temps ? Trois semaines ?\" Tu expliques que ça prend généralement 12 à 18 mois. Thomas fait un calcul mental : \"OK mais nous on est agiles, on peut faire ça en 6 mois, non ?\" Tu négoces 9 mois, sachant que tu en auras 12.

Le premier jalon est la rédaction de la politique de sécurité de l'information. Tu rédiges un document de 45 pages. Romain le lit et te dit : \"C'est bien mais c'est un peu corporate, non ? Chez nous on est cools.\" Tu expliques que la norme ISO 27001 ne prévoit pas de clause \"on est cools\". L'analyse de risques révèle 127 risques critiques. Thomas te demande si on peut les \"prioriser à 5\".

L'exercice de certification te confronte à un dilemme stratégique. D'un côté, ISO 27001 est le chemin balisé — long, structuré, reconnu. De l'autre, tu sens que le vrai besoin est ailleurs : les clients américains veulent du SOC2 Type II, et c'est aussi une rumeur d'acquisition qui circule dans les couloirs. Si NexaFlow se fait racheter, c'est la posture sécu qui déterminera la valorisation. Tu ne peux pas tout mener de front. ISO 27001 ou SOC2 ? La certification qui rassure le marché français ou celle qui ouvre le marché US ? Et cette rumeur d'acquisition — tu la prends au sérieux ou tu l'ignores ? Chaque choix engage des mois de travail et un budget que tu n'auras qu'une fois."

DIVERGE_POINT_9=$(git rev-parse HEAD)

# --- MAIN COMMIT 11 ---
git commit --allow-empty -m "Les signaux d'alerte montent dans le silence — quelque chose se prépare et personne ne veut écouter

Ça fait huit mois que tu es en poste. Les indicateurs de sécurité que tu as mis en place clignotent tous en rouge. Le nombre de tentatives de connexion suspectes a triplé en trois mois. Un scan automatique a détecté des ports ouverts sur des services que personne ne savait encore en production. Le SIEM que tu as réussi à faire installer montre des patterns inhabituels : quelqu'un ou quelque chose sonde méthodiquement votre infrastructure depuis une IP ukrainienne. Stéphane dit que c'est \"normal, c'est les scanners habituels d'Internet\". Tu n'es pas convaincu.

En parallèle, Julie a quitté l'entreprise le mois dernier. Son offboarding a consisté en un \"au revoir\" sur Slack et un pot de départ. Personne n'a révoqué ses accès. Tu vérifies : elle a encore accès à GitHub, AWS, Slack, et au Google Drive contenant les données financières. Son token API personnel est toujours actif dans trois microservices en production. Tu envoies un mail urgent à Romain. Il te répond trois jours plus tard : \"Ah oui, j'avais oublié. De toute façon Julie est cool, elle ne ferait rien de mal.\"

Tu fermes les yeux. Le SIEM clignote. Les scans continuent. Les accès non révoqués s'accumulent. Et personne ne t'écoute. Tu le sens dans tes tripes : quelque chose se prépare. Ce n'est pas de la paranoïa — c'est quinze ans d'expérience qui hurlent. Mais que faire ? Tu peux continuer à te battre de l'intérieur, à absorber le stress, à pousser des alertes que personne ne lit — en espérant que la crise n'arrive pas avant que tu aies fini de consolider. Ou tu peux partir. Ta santé mentale se dégrade, le budget vient d'être coupé, et la culture ne change pas assez vite. Si tu restes et que ça explose, tu seras le bouc émissaire. Si tu pars, personne ne sera là pour limiter les dégâts. Dans les deux cas, tu perds."

DIVERGE_POINT_10=$(git rev-parse HEAD)

# --- MAIN COMMIT 12 ---
git commit --allow-empty -m "Le calme avant la tempête

Curieusement, les trois dernières semaines ont été calmes. Trop calmes. Le VPN ne plante plus (tu as fini par obtenir l'upgrade de l'instance). Le MFA est accepté (les post-its ont été remplacés par de vrais authenticators, du moins chez 60% des employés). Tu as réussi à faire passer le scan de secrets en CI/CD — ça bloque un commit sur cinq, mais au moins les nouveaux secrets ne fuient plus. Stéphane a même accepté de documenter ses procédures (sur un bout de papier, certes, mais c'est un début).

Tu commences presque à croire que ça va aller. Thomas te félicite en comité de direction : \"Notre CISO fait un boulot incroyable, la sécu est vraiment un sujet important pour nous.\" Romain hoche la tête. Amira te sourit. Tu te méfies de ce calme. Quinze ans de cybersécurité t'ont appris que le calme est toujours le prépit de quelque chose. Ton téléphone vibre à 23h47 un dimanche soir. C'est un SMS de PagerDuty. Tu lis les trois premiers mots et ton sang se glace : \"Critical: Unauthorized access detected.\""

# --- MAIN COMMIT 13 ---
git commit --allow-empty -m "La crise — 72 heures en enfer

Dimanche 23h47. Tu es en pyjama devant Netflix. Le SMS de PagerDuty est suivi d'un deuxième, puis d'un troisième. Tu ouvres ton laptop. Le SIEM s'affole : des mouvements latéraux détectés sur le réseau, des connexions depuis des IP inconnues, des fichiers qui sont modifiés sur les serveurs de production. Quelqu'un est à l'intérieur. Tu appelles Romain. Il ne répond pas (c'est dimanche). Tu appelles Stéphane. Il répond à la quatrième sonnerie : \"Hmm, je vais regarder.\" Il regarde. Silence. \"Oh merde.\"

Les 72 heures suivantes sont un brouillard de café, de stress et de sueur froide. Tu actives le plan de réponse à incident que tu avais rédigé trois mois plus tôt et que personne n'avait lu. Tu découvres que la moitié des actions du plan sont inapplicables parce que les outils nécessaires n'ont jamais été déployés (budget refusé). Tu isoles les systèmes compromis, tu changes tous les mots de passe, tu révoques tous les tokens. Thomas appelle toutes les heures pour demander \"c'est fini ?\". Amira prépare la notification CNIL (tu as 72h, le chrono tourne). Le board veut un rapport. Les clients posent des questions. La presse tech commence à s'intéresser à l'affaire. Tu n'as pas dormi depuis 40 heures."

# --- MAIN COMMIT 14 ---
git commit --allow-empty -m "L'autopsie, ou comment on en est arrivé là

La crise est contenue. L'analyse forensique révèle le vecteur d'attaque : l'ancien token API de Julie, toujours actif dans un microservice exposé sur Internet. Un attaquant l'a trouvé dans le cache d'un moteur de recherche de code (il avait été commité dans le repo il y a deux ans). De là, il a pivoté vers la base de données, extrait des données clients, et tenté de déployer un ransomware. Le ransomware a échoué — non pas grâce à vos défenses, mais parce que l'attaquant a utilisé un exploit prévu pour Windows et vos serveurs sont sous Linux. La chance. Pure et simple.

Tu rédiges le post-mortem. 23 pages. Tu y détailles chaque défaillance : l'absence de révocation des accès, les secrets dans le code, le monitoring insuffisant, les backups non testées (spoiler : les restaurer a pris 14 heures au lieu des 2 heures annoncées), le plan de réponse non testé. Thomas lit le rapport. Pour la première fois depuis que tu es là, il ne sourit pas. Il te regarde et dit : \"Qu'est-ce qu'il te faut ?\" Pas \"combien ça coûte\". Pas \"c'est vraiment nécessaire\". Juste \"qu'est-ce qu'il te faut\". Tu sens que quelque chose vient de changer."

# --- MAIN COMMIT 15 ---
git commit --allow-empty -m "La reconstruction, ou la phénix qui reboot

Six mois après la crise. NexaFlow n'est plus la même boîte. Tu as obtenu un budget sécu qui représente 12% du budget IT (contre 0% avant ton arrivée). Tu as recruté deux analystes sécu. Le MFA est à 100%. Les secrets sont gérés dans Vault. Les accès sont revus tous les trimestres. L'offboarding inclut maintenant la révocation de TOUS les accès dans les 24 heures. Le SIEM est configuré correctement (les faux positifs sont tombés à 30%). Tu as même réussi à convaincre Stéphane d'arrêter de se connecter en root direct.

La certification ISO 27001 est en cours, pour de vrai cette fois. L'audit SOC2 avance. Les devs ont adopté le shift-left security (après avoir beaucoup râlé). Romain est devenu ton meilleur allié — la crise l'a converti. Il dit maintenant \"security by design\" dans chaque réunion, parfois hors contexte, mais l'intention est là. Thomas raconte l'histoire de l'incident à chaque nouveau client enterprise comme preuve de \"résilience\". Tu lèves les yeux au ciel mais tu laisses faire — c'est du marketing, pas de la sécu. Ton ulcère va mieux. Tu dors 6 heures par nuit au lieu de 4. C'est un progrès."

# --- MAIN COMMIT 16 (final main) ---
git commit --allow-empty -m "Épilogue : Le CISO qui voyait des failles partout... avait raison

Un an et demi après ton arrivée. Tu es dans la salle de réunion du board. On te demande de présenter le bilan sécurité annuel. Tu affiches tes dashboards. Les métriques sont au vert — enfin, au jaune, mais c'est le nouveau vert dans la cybersécurité. Zéro incident majeur depuis la crise. Temps moyen de détection passé de \"jamais\" à 4 heures. Taux de clic sur le phishing simulé passé de 43% à 8%. Les secrets dans le code : zéro dans les 6 derniers mois.

Thomas prend la parole : \"Quand on a recruté notre CISO, certains pensaient que c'était excessif pour une boîte de notre taille. Je fais mon mea culpa : on aurait dû le faire trois ans plus tôt.\" Romain acquiesce. Même Stéphane, connecté en visio depuis le datacenter (oui, il y va encore physiquement), lève un pouce. Tu ne souris pas. Tu ne célèbres pas. Parce que tu sais. Tu sais que la prochaine faille est là, quelque part, tapie dans un recoin de code que personne n'a audité, dans un SaaS que quelqu'un vient d'installer sans te prévenir, dans un mot de passe que quelqu'un vient de coller sur un post-it. Tu es le CISO qui voit des failles partout. Et tu avais raison depuis le début."

MAIN_TIP=$(git rev-parse HEAD)

# ============================================================================
# BRANCHES SECONDAIRES
# ============================================================================

# --------------------------------------------------------------------------
# feature/zero-trust — diverge après le MFA (DIVERGE_POINT_3)
# --------------------------------------------------------------------------
git checkout -b feature/zero-trust $DIVERGE_POINT_3

git commit --allow-empty -m "Tu proposes le modèle Zero Trust au board

L'idée te vient un soir en relisant un whitepaper de Google sur BeyondCorp. Si personne ne fait confiance à personne, alors personne ne peut trahir cette confiance. C'est beau, c'est élégant, c'est mathématique. Tu prépares une présentation de 40 slides intitulée \"Zero Trust : ne faites confiance à personne, même pas à vous-même\". Thomas adore le titre. Romain lève un sourcil : \"Ça veut dire que mes devs ne pourront plus accéder au code ?\" Tu expliques que c'est plus subtil que ça. Spoiler : ça ne sera pas subtil du tout."

git commit --allow-empty -m "Implémentation phase 1 — l'authentification continue

Tu déploies un système d'authentification continue. Chaque accès à chaque ressource nécessite une vérification. Tu ouvres un Google Doc ? Vérification. Tu clones un repo ? Vérification. Tu accèdes à Slack ? Vérification. Tu vas aux toilettes ? Bon, pas encore, mais l'idée te traverse l'esprit. Le premier jour, un développeur doit s'authentifier 47 fois pour faire un déploiement en prod. Il te envoie un Slack (après s'être authentifié pour accéder à Slack) : \"C'est une blague ?\". Ce n'est pas une blague. Tu as segmenté le réseau en 23 micro-zones. Pour passer d'une zone à l'autre, il faut un ticket. Le ticket expire en 15 minutes. Le temps moyen d'un déploiement passe de 20 minutes à 3 heures."

git commit --allow-empty -m "La productivité s'effondre, les développeurs se rebellent

Semaine 2 du Zero Trust. Les métriques de productivité chutent de 60%. Les développeurs ont créé un channel Slack privé intitulé #resistance-zero-trust (tu le sais parce que tu as accès aux logs — Zero Trust signifie aussi que TU vois tout). Romain débarque à ton bureau avec un graphique montrant le nombre de features livrées : la courbe ressemble à la chute d'une falaise. Les commerciaux ne peuvent plus faire de démo client parce que le système bloque l'accès au sandbox depuis un réseau Wi-Fi non reconnu (le Wi-Fi du client). Un commercial a dû faire une démo via un partage d'écran... de son téléphone... en 4G... avec 2 barres de réseau. La démo a duré 45 minutes au lieu de 15. Le client a signé chez un concurrent."

git commit --allow-empty -m "Le CEO intervient, tu dois faire des compromis

Thomas te convoque. Son sourire habituel a disparu. \"J'adore le concept de Zero Trust, c'est très... ambitieux. Mais là on a perdu 3 deals cette semaine parce que les commerciaux ne peuvent pas travailler.\" Tu essaies d'expliquer que la sécurité a un coût. Thomas te répond que le coût actuel est de 180K€ de revenus perdus en deux semaines. Tu ravales ta salive. Tu dois assouplir. Tu crées des \"zones de confiance conditionnelle\" — un oxymore magnifique qui signifie \"Zero Trust mais pas trop\". Les devs retrouvent un accès facilité au code. Les commerciaux peuvent refaire des démos. Stéphane, lui, n'a jamais été impacté : il a trouvé une faille dans ton système le jour 1 et ne t'a pas prévenu. Il te le dit maintenant, avec un sourire narquois."

git commit --allow-empty -m "Bilan — le Zero Trust tempéré, ou l'art du compromis

Le Zero Trust intégral aura duré exactement 16 jours. Le Zero Trust \"pragmatique\" (le terme que tu utilises maintenant) fonctionne mieux : authentification renforcée pour les accès sensibles, MFA everywhere, micro-segmentation sur les systèmes critiques, mais liberté relative pour le quotidien. C'est un compromis. En cybersécurité, tout est compromis. Le mot \"compromis\" signifie à la fois \"accord mutuel\" et \"système pénétré par un attaquant\". Tu trouves ça poétique et déprimant à la fois.

La leçon que tu retiens : la sécurité parfaite est l'ennemie de la sécurité possible. Tu graves cette phrase sur un post-it que tu colles sur ton écran. Puis tu réalises l'ironie d'un CISO qui utilise des post-its."

git checkout main

# --------------------------------------------------------------------------
# feature/phishing-campaign — diverge après la formation phishing (DIVERGE_POINT_5)
# --------------------------------------------------------------------------
git checkout -b feature/phishing-campaign $DIVERGE_POINT_5

git commit --allow-empty -m "Tu décides d'intensifier les campagnes de phishing simulé

Les résultats de la première campagne étaient tellement catastrophiques que tu décides de transformer ça en programme permanent. Une campagne par mois, de plus en plus sophistiquée. Tu commences par les classiques : faux mails de réinitialisation de mot de passe, fausses factures, faux colis en attente. Le taux de clic baisse de 43% à 35%. Progrès. Tu montes d'un cran : tu personnalises les mails. Tu utilises les infos publiques des réseaux sociaux des employés. Thomas reçoit un faux mail de son club de golf. Il clique. Encore."

git commit --allow-empty -m "Les campagnes deviennent de plus en plus élaborées

Mois 3. Tu crées un faux site web de commande de repas d'entreprise avec un formulaire demandant les identifiants corporate \"pour la facturation\". 22 employés remplissent le formulaire. Tu crées un faux mail du CEO annonçant des augmentations avec un lien vers \"le détail des augmentations\" qui demande de se connecter. 67% de l'entreprise clique. Romain te tire son chapeau : \"C'est vicieux, je suis impressionné.\" Tu ne sais pas si c'est un compliment.

Mois 4. Tu achètes un domaine quasi-identique (nexaf1ow.com au lieu de nexaflow.com) et tu envoies des mails depuis ce domaine. Tu clones la page de login Google Workspace. Tu ajoutes des éléments de contexte réels (noms de projets, dates de réunions) que tu trouves dans les calendriers partagés. Le taux de clic remonte à 41%. Les employés sont furieux. Pas contre les hackers. Contre toi."

git commit --allow-empty -m "Le vishing — tu passes aux appels téléphoniques

Tu décides de tester le vishing (phishing vocal). Tu engages un prestataire qui appelle les employés en se faisant passer pour le support IT : \"Bonjour, c'est le support informatique, on a détecté une activité suspecte sur votre compte, on a besoin de votre mot de passe pour vérifier.\" 8 employés sur 30 testés donnent leur mot de passe au téléphone. Maxence donne non seulement son mot de passe mais aussi celui de son manager (\"au cas où vous en avez besoin aussi\"). Le directeur financier donne son mot de passe ET le code de la carte bancaire corporate \"pour vérification\". Tu te demandes si tu ne devrais pas aussi tester la résistance au social engineering en personne — se pointer à l'accueil avec un gilet de technicien et voir jusqu'où on peut aller."

git commit --allow-empty -m "La plainte RH — tu es allé trop loin

Le mail de trop. Tu envoies un faux mail de licenciement économique (\"Votre poste est supprimé, cliquez ici pour vos indemnités\"). Trois personnes font une crise de panique. Une employée appelle son avocat avant de réaliser que c'est un test. Un développeur, qui était déjà en période de fragilité, part en arrêt maladie. Les RH débarquent dans ton bureau avec un dossier. Le délégué du personnel te convoque. Thomas t'appelle : \"On m'a dit que tu avais annoncé des licenciements ?\" Tu expliques. Le silence au bout du fil est glacial. \"On va... recadrer le programme de phishing.\"

La DRH t'envoie un mail formel te rappelant que les campagnes de sensibilisation doivent respecter \"la dignité des salariés\" et \"ne pas créer un climat de harcèlement moral\". Amira t'explique que juridiquement, tu es en zone grise. Romain, pour une fois, est de ton côté : \"L'intention était bonne.\" Merci Romain, c'est exactement ce que les avocats détestent entendre."

git commit --allow-empty -m "Le programme renaît, version éthique et encadrée

Après deux semaines de purgatoire, tu relances le programme avec un cadre strict : pas de mails à contenu émotionnel fort (licenciement, maladie, décès), pas de personnalisation excessive, prévention du comité social et économique, et surtout, formation systématique après chaque campagne plutôt que du pur \"gotcha\". Le nouveau format : quand quelqu'un clique, il est redirigé vers une page qui explique les signaux d'alerte, avec un quiz ludique. Le taux de clic descend à 12% en trois mois.

La vraie victoire : les employés commencent à signaler les vrais mails de phishing. Le channel #suspicion-phishing que tu as créé reçoit 15 à 20 signalements par semaine. 80% sont de vrais phishings. Tu as créé un réflexe. Pas avec la peur, mais avec l'habitude. C'est moins glorieux dans les conférences sécu, mais c'est ce qui marche."

git checkout main

# --------------------------------------------------------------------------
# feature/soc2-certification — diverge après ISO 27001 (DIVERGE_POINT_9)
# --------------------------------------------------------------------------
git checkout -b feature/soc2-certification $DIVERGE_POINT_9

git commit --allow-empty -m "soc2 1/6 : L'annonce du projet SOC2, ou le début de la fin de ta santé mentale

Thomas revient d'un salon tech aux États-Unis. Les prospects américains lui ont posé THE question : \"Are you SOC2 compliant?\" Thomas a dit oui. Il a menti. Il t'annonce : \"Il nous faut le SOC2 Type II en 6 mois.\" Tu lui expliques que SOC2 Type II nécessite une période d'observation de minimum 6 mois APRÈS avoir mis en place tous les contrôles. Donc au mieux 12 mois. Thomas : \"Oui mais si on fait les contrôles vite ?\" Tu passes une heure à expliquer la différence entre Type I et Type II. Thomas retient : \"Alors on fait le Type I d'abord, c'est plus rapide, non ?\" Techniquement oui. Pratiquement, c'est comme dire \"on passe le permis de conduire version théorique d'abord\" quand on n'a pas de voiture."

git commit --allow-empty -m "soc2 2/6 : Le choix de l'auditeur, ou la rencontre du troisième type

Tu reçois trois propositions de cabinets d'audit. Le premier est tellement cher que le devis contient plus de chiffres que ton numéro de sécurité sociale. Le deuxième est \"abordable\" mais basé dans un pays que tu ne peux pas situer sur une carte. Le troisième, BDG Audit, semble raisonnable : 80K€ pour le Type II complet. Thomas négocie à 65K€ en promettant \"un témoignage client\". L'auditeur principal s'appelle Marc. Marc a l'air d'un homme qui n'a pas souri depuis 2016 et qui trouve du plaisir exclusivement dans la découverte de non-conformités.

Marc envoie la liste des preuves à fournir. 247 items. Tu imprimes la liste (oui, tu imprimes, c'est le choc). Elle fait 12 pages. Chaque item est une preuve documentaire d'un contrôle : politique de gestion des accès (tu en as une, de la semaine dernière), logs de revue des accès (tu n'en as pas), procédure de gestion des incidents (tu as un brouillon), preuve de tests de restauration des backups (tu ris nerveusement), évaluation annuelle des risques fournisseurs (tu pleures intérieurement)."

git commit --allow-empty -m "soc2 3/6 : La collecte de preuves, ou la chasse au trésor infernale

Tu crées un Google Drive partagé avec 247 dossiers. Chaque dossier correspond à un contrôle. En 3 semaines, tu dois les remplir. Tu mobilises Romain pour les contrôles techniques, Amira pour les contrôles juridiques, les RH pour les contrôles de gestion du personnel, et Stéphane pour... Stéphane n'a rien documenté depuis 2019. Tu lui demandes des preuves de monitoring des serveurs. Il t'ouvre un terminal et te montre htop : \"Tu vois, là, tout est vert.\" Tu lui expliques qu'une preuve c'est un screenshot horodaté dans un document formel. Il te regarde comme si tu venais de lui demander de peindre la Joconde avec les pieds.

Après 6 semaines, 180 items sur 247 sont remplis. Les 67 restants sont des choses qui n'existent tout simplement pas : revue trimestrielle des accès (\"on n'a jamais fait ça\"), tests d'intrusion annuels (\"c'est quoi ?\"), plan de continuité d'activité (\"si ça tombe, on répare\"), et formation sécurité obligatoire avec tracking (\"les gens lisent le wiki s'ils veulent\"). Tu dois tout créer from scratch en prétendant que ça existe depuis des mois. L'éthique te chatouille mais les deadlines ne négocient pas."

git commit --allow-empty -m "soc2 4/6 : L'audit sur site, ou Marc contre NexaFlow

Marc arrive un mardi avec un collègue qui ne parle pas et prend des notes. Marc veut voir \"les preuves en live\". Il demande à un employé au hasard de lui montrer comment il change son mot de passe. L'employé panique et dit : \"Je sais pas, c'est toujours le même.\" Marc note. Il demande à voir la procédure d'onboarding sécurité. Tu montres le document que tu as rédigé le mois dernier. Marc demande : \"Depuis quand cette procédure est en place ?\" Tu mens : \"Six mois.\" Marc demande des preuves d'application. Tu montres des attestations signées. Marc remarque que toutes les signatures ont la même date. La même date que la semaine dernière. Marc note.

L'audit dure trois jours. Marc trouve 34 non-conformités. Dont 8 majeures. Il découvre que les logs de modification de la base de données n'existent pas (\"on loggue les erreurs, pas les succès\"). Il découvre que 3 employés ont des accès admin sans justification documentée. Il découvre que le backup n'a jamais été testé en condition réelle. Tu proposes un plan de remédiation. Marc te donne 90 jours."

git commit --allow-empty -m "soc2 5/6 : La remédiation, ou les 90 jours les plus longs de ta vie

90 jours pour corriger 34 non-conformités dont 8 majeures. Tu crées un war room (une salle de réunion squattée en permanence). Tu recrutes un prestataire pour t'aider. Le prestataire coûte 1500€ par jour mais il connaît Marc (\"Marc cherche toujours le même genre de trucs, t'inquiète\"). Tu travailles 14 heures par jour. Tu implémentes les logs manquants. Tu fais une vraie revue des accès (12 personnes avaient des accès dont elles n'avaient plus besoin). Tu testes les backups (résultat : la restauration échoue sur 2 bases sur 7, tu corriges en urgence). Tu crées les procédures manquantes. Tu formes les employés. Tu documentes tout.

Le jour 87, tu as corrigé 32 non-conformités sur 34. Les 2 restantes sont un problème d'architecture fondamentale (la base de données n'est pas chiffrée au repos) et un problème de continuité d'activité (pas de site de repli). Pour la base, tu mets en place le chiffrement en un week-end de terreur (la migration prend 18 heures et tu perds 2 heures de données, rattrapées grâce à un log que tu avais justement mis en place pour Marc). Pour le site de repli, tu mets en place un DR basique sur une autre région AWS. Ça tiendra pour l'audit."

git commit --allow-empty -m "soc2 6/6 : Le rapport final, ou la victoire à la Pyrrhus

Marc revient. Il vérifie tout. Tout. Chaque correction, chaque preuve, chaque signature. Il pose des questions pièges aux employés (\"Que faites-vous si vous recevez un mail suspect ?\" — cette fois, 90% répondent correctement). Il teste les restaurations de backup. Ça marche. Il vérifie les logs. Ils sont là. Il cherche des non-conformités résiduelles. Il en trouve 3 mineures. Tu t'en fiches, les mineures ne bloquent pas la certification.

Le rapport SOC2 Type II arrive 6 semaines plus tard. NexaFlow est conforme. Thomas sabre le champagne (métaphoriquement — il ouvre un Saint-Véran à 12€). Le rapport fait 89 pages. Personne ne le lira jamais. Mais les commerciaux peuvent maintenant cocher la case \"SOC2 Compliant\" dans les appels d'offres. Le coût total de l'opération : 215K€ (audit 65K€ + prestataire 90K€ + outils 40K€ + heures sup non payées : inestimable). Thomas demande : \"C'est bon, on est tranquilles pour combien de temps ?\" Tu réponds : \"Un an. Ensuite on recommence.\" Son sourire s'efface."

git checkout main

# --------------------------------------------------------------------------
# feature/bug-bounty — diverge après secrets dans le code (DIVERGE_POINT_6)
# --------------------------------------------------------------------------
git checkout -b feature/bug-bounty $DIVERGE_POINT_6

git commit --allow-empty -m "Tu proposes un programme de bug bounty, Thomas dit \"gratuit c'est bien\"

L'idée te semble logique : plutôt que d'attendre qu'un hacker malveillant trouve tes failles, autant payer des hackers éthiques pour les trouver avant. Tu présentes le concept à Thomas. Ses yeux brillent quand tu dis \"certaines boîtes font ça pour pas cher\". Ses yeux s'éteignent quand tu dis \"le budget moyen est de 50 à 200K€ par an pour les bounties\". Il contre-propose : \"On peut pas juste mettre une page sur notre site qui dit 'si vous trouvez un bug, écrivez-nous' ?\" Tu expliques que c'est le meilleur moyen de ne recevoir que du spam. Après négociation, tu obtiens un budget de 20K€ pour un programme limité via HackerOne. C'est ridiculement bas mais c'est un début."

git commit --allow-empty -m "Le programme est live, premier rapport en 2 heures

Tu lances le programme un mercredi à 10h. À 12h07, le premier rapport arrive. Un hacker de 17 ans basé à Bucarest (pseudo : x_darkbyte_x) a trouvé une faille critique : une injection SQL sur l'API de recherche qui donne accès à l'intégralité de la base de données clients. Le rapport est impeccable : description de la vulnérabilité, preuve de concept, impact estimé, recommandation de correction. Le gamin a fait en 2 heures ce que ton scan automatique n'a pas trouvé en 3 mois.

Tu montres le rapport à Romain. Il pâlit. \"C'est possible ça ? Mais on utilise un ORM...\" Tu lui montres l'endpoint vulnérable : un vieil endpoint \"legacy\" écrit en 2019 par un dev qui a quitté la boîte, avec du SQL brut concaténé. Personne ne savait qu'il existait encore. Romain le corrige en urgence. Tu paies 2500€ de bounty. Thomas : \"2500€ pour un bug ? C'est cher.\" Tu lui expliques que si un attaquant avait trouvé ça en premier, ça aurait coûté beaucoup plus que 2500€. Il ne semble pas convaincu."

git commit --allow-empty -m "Les rapports affluent, ton budget fond comme neige au soleil

En deux semaines, tu as reçu 47 rapports. 12 sont des doublons, 8 sont du bruit (\"votre site n'a pas le header X-Frame-Options\" — merci Captain Obvious), mais 27 sont des vraies vulnérabilités. Dont 5 critiques. x_darkbyte_x est devenu un habitué : il a trouvé 8 failles à lui tout seul et a déjà empoché 7000€. Ton budget de 20K€ est à moitié consommé. Les développeurs sont démoralisés : à chaque standup, tu arrives avec une nouvelle faille à corriger. Romain commence à te regarder comme le facteur de mauvaises nouvelles.

La faille la plus embarrassante : x_darkbyte_x a trouvé un endpoint admin non protégé qui permet de télécharger le backup complet de la base de données. En production. Sans authentification. L'URL est /api/admin/dump-db. Personne ne sait qui l'a créé. Le commit date de 2020. L'auteur est un certain \"dev_temp\" dont personne ne se souvient. Le bounty pour celle-là : 5000€. Thomas apprend l'existence de cet endpoint et ne dort pas de la nuit."

git commit --allow-empty -m "x_darkbyte_x veut un stage, les devs veulent une pause

x_darkbyte_x t'envoie un mail : \"Bonjour, j'ai 17 ans, je suis en terminale à Bucarest, et je cherche un stage en cybersécurité. Votre application m'a beaucoup appris.\" Tu ris. Puis tu réalises que ce gamin de 17 ans a une meilleure compréhension de votre infrastructure que 90% de tes collègues. Tu en parles à Thomas qui est partagé entre l'admiration et l'angoisse : \"Tu veux recruter le gars qui a trouvé toutes nos failles ? C'est comme embaucher le cambrioleur pour garder la maison.\" Tu lui expliques que c'est exactement le principe du bug bounty. Il n'est pas rassuré.

Pendant ce temps, l'équipe dev demande une pause. En 3 semaines, ils ont corrigé 27 vulnérabilités en plus de leur travail habituel. La vélocité de l'équipe a chuté de 40%. Le product manager vient te voir : \"On ne peut pas livrer la feature que le client attend à cause de tes bugs.\" Tu lui rappelles que ce ne sont pas TES bugs. L'ambiance est tendue. Tu proposes un compromis : les vulnérabilités critiques sont corrigées immédiatement, les moyennes en sprint +1, les faibles en sprint +2. Romain accepte du bout des lèvres."

git commit --allow-empty -m "Bilan — 20K€ bien dépensés, et un stagiaire roumain

Trois mois après le lancement, le bilan du bug bounty : 89 rapports, 43 vraies vulnérabilités, 12 critiques, 18 moyennes, 13 faibles. Budget total dépensé : 23K€ (tu as dépassé de 3K€, mais Thomas a accepté quand tu lui as montré la dernière faille — un contournement d'authentification qui donnait accès au panel d'administration). L'application est objectivement plus sûre. Les développeurs ont appris plus en 3 mois qu'en 5 ans sur la sécurité applicative.

x_darkbyte_x, alias Andrei, fait finalement un stage de 2 mois à distance. Il trouve encore 3 failles pendant son stage, dont une dans le code qu'un dev venait de livrer le jour même. Le dev en question, vexé, quitte la salle de standup. Andrei deviendra consultant en sécurité à 19 ans. Il mettra NexaFlow en référence sur son CV. Tu te demandes si c'est flatteur ou humiliant."

git checkout main

# --------------------------------------------------------------------------
# feature/security-champions — diverge après la politique mots de passe (DIVERGE_POINT_4)
# --------------------------------------------------------------------------
git checkout -b feature/security-champions $DIVERGE_POINT_4

git commit --allow-empty -m "L'idée du programme Security Champions

Tu as lu dans un article Medium (la Bible du CISO moderne) qu'un programme de \"Security Champions\" transforme la culture de sécurité. Le concept : identifier un volontaire dans chaque équipe qui devient le relais sécurité. Ce champion reçoit une formation spéciale, participe aux décisions sécu, et évangélise les bonnes pratiques dans son équipe. C'est beau sur le papier. Tu envoies un mail à toute l'entreprise : \"Qui veut devenir Security Champion ?\". Zéro réponse en 48h. Tu relances. Une réponse : Maxence, le stagiaire. Tu déclines poliment."

git commit --allow-empty -m "Le recrutement forcé, ou le volontariat obligatoire

Puisque personne ne se porte volontaire, tu passes au plan B : demander aux managers de désigner quelqu'un. Romain désigne le dev le plus junior de son équipe (\"ça lui fera une expérience\"). Le directeur commercial désigne la personne qui vient de rater sa période d'essai (\"ça la valorisera\"). Le marketing désigne quelqu'un qui est en congé maternité (\"elle sera super motivée à son retour\"). Le support désigne Stéphane parce que \"c'est technique\". Stéphane refuse catégoriquement : \"La sécu c'est TON job, pas le mien.\"

Tu te retrouves avec 6 \"champions\" dont 4 n'ont aucune idée de pourquoi ils sont là, 1 est absent, et 1 (le dev junior) est terrorisé. Tu organises la première réunion. Trois personnes viennent. Le dev junior prend des notes frénétiquement. Le commercial regarde son téléphone. La personne du support joue à Candy Crush mais comme elle est en présentiel, elle essaie de le cacher derrière un carnet."

git commit --allow-empty -m "La formation, ou comment expliquer les injections SQL au marketing

Tu prépares un programme de formation de 8 sessions. Session 1 : les bases de la sécurité informatique. Tu expliques les injections SQL. Le commercial demande : \"Ça peut arriver sur Excel ?\" Tu expliques le cross-site scripting. La personne du marketing demande : \"C'est comme quand mon site Wix a été piraté ?\" Tu expliques les failles d'authentification. Le dev junior dit : \"Ah mais ça c'est ce que fait notre API de login.\" Tu t'arrêtes. \"Comment ça ?\" Il t'explique que l'API de login compare les mots de passe en texte clair côté client. Tu annules la session et tu pars corriger le code avec lui. C'est la session la plus productive du programme."

git commit --allow-empty -m "Six mois plus tard, le programme a survécu (à peine)

Sur les 6 champions initiaux, il en reste 3. Le dev junior est devenu un vrai allié : il fait des code reviews orientées sécurité et a trouvé deux failles dans les pull requests de ses collègues. La personne du support a développé une expertise inattendue en détection de phishing et forme maintenant les nouveaux arrivants. Le commercial a disparu dans la nature (\"trop de boulot, désolé\"). La personne en congé maternité est revenue et a demandé à quitter le programme (\"j'ai déjà assez de trucs à rattraper\"). Stéphane a fini par rejoindre de lui-même, non pas par conviction mais parce que \"si personne ne fait les trucs correctement, autant que je sois là\".

Le programme n'est pas le succès éclatant que tu avais imaginé, mais il existe. C'est déjà plus que ce que 80% des boîtes de cette taille ont. Le dev junior te dit un jour : \"Avant le programme, je ne pensais jamais à la sécu quand je codais. Maintenant j'y pense tout le temps. C'est un peu stressant.\" Tu souris. Bienvenue dans mon monde, gamin."

git checkout main

# --------------------------------------------------------------------------
# feature/siem-monitoring — diverge après le VPN (DIVERGE_POINT_7)
# --------------------------------------------------------------------------
git checkout -b feature/siem-monitoring $DIVERGE_POINT_7

git commit --allow-empty -m "Tu veux un SIEM, Thomas veut savoir ce que c'est

\"Security Information and Event Management\". Tu prononces ces mots et tu vois les yeux de Thomas se vitrifier. Tu traduis : \"C'est un outil qui collecte tous les logs de tous les systèmes et qui détecte les menaces automatiquement.\" Thomas comprend \"outil magique qui fait la sécu tout seul\". Tu essaies de corriger cette impression. Thomas a déjà décidé : \"Super, on prend ça et on est tranquilles !\" Tu soupires. Tu commences l'évaluation : Splunk (hors budget, le pricing est au volume de données et NexaFlow génère 50 Go de logs par jour), Elastic SIEM (\"gratuit\" mais nécessite 3 ingénieurs à plein temps pour le maintenir), et une solution cloud \"abordable\" qui s'appelle AlertHawk (tu n'en as jamais entendu parler, mais le commercial est très persuasif). Thomas choisit AlertHawk parce que \"le commercial est sympa et il y a une offre à -40%\"."

git commit --allow-empty -m "Le déploiement, ou la noyade dans les logs

Le déploiement d'AlertHawk prend 6 semaines au lieu des 2 promises par le commercial sympa. La raison : personne n'avait prévu que NexaFlow utilise 47 sources de données différentes et que 30% d'entre elles n'ont pas de format de log standard. Stéphane logge ses serveurs dans un format custom qu'il a inventé en 2019 (\"c'est plus lisible\"). Les microservices loggent en JSON, sauf trois qui loggent en texte brut. Le load balancer logge dans un format que même AlertHawk ne reconnaît pas.

Tu passes deux semaines à écrire des parsers. Le SIEM est enfin connecté. Tu ouvres le dashboard. 500 alertes. Par jour. Tu cliques sur la première : \"Suspicious login attempt from unknown IP.\" C'est Stéphane qui se connecte depuis chez lui avec une IP dynamique. Deuxième alerte : \"Unusual data transfer detected.\" C'est le backup quotidien. Troisième alerte : \"Multiple failed authentication attempts.\" C'est le bot de monitoring qui teste les endpoints et dont personne n'a configuré les credentials correctement. 499 faux positifs sur 500. La vraie menace, si elle existe, est noyée dans le bruit."

git commit --allow-empty -m "Le tuning des règles, ou l'art de chercher une aiguille dans 500 meules de foin

Tu passes les 4 semaines suivantes à \"tuner\" les règles de détection. C'est un travail de moine : chaque faux positif doit être analysé, catégorisé, et soit whitelist, soit sa règle de détection doit être affinée. Semaine 1 : tu passes les alertes de 500 à 350 par jour en whitelistant les IPs internes. Semaine 2 : tu descends à 200 en excluant les patterns de backup et monitoring. Semaine 3 : 120, en affinant les seuils de détection de brute force. Semaine 4 : 80, et tu commences à voir de vrais trucs intéressants dans le bruit.

Parmi les découvertes : un serveur de staging oublié qui mine du Bitcoin depuis 3 mois (quelqu'un a compromis le container Docker), un employé qui accède à des fichiers RH auxquels il ne devrait pas avoir accès (c'est le délégué du personnel, techniquement c'est légal, mais les accès n'auraient pas dû être là), et des scans de ports réguliers depuis une IP en Russie qui ciblent spécifiquement vos endpoints API. Ce dernier point te tient éveillé la nuit."

git commit --allow-empty -m "L'alerte critique noyée, ou le cri dans la tempête

Un jeudi à 15h, AlertHawk génère une alerte de sévérité \"critique\" : \"Exfiltration pattern detected — unusual outbound data volume from production database.\" Tu es en réunion SOC2 avec Marc l'auditeur. Ton téléphone vibre mais tu ne regardes pas. L'alerte est suivie de 47 autres alertes, dont 45 sont des faux positifs habituels (le batch de facturation mensuel qui génère du trafic). L'alerte critique se noie dans le flux. Tu la vois 4 heures plus tard en revenant à ton bureau.

Tu investigues. Le pattern était réel : quelqu'un (ou quelque chose) a extrait 2 Go de données de la base production vers un serveur externe. Mais quand tu analyses plus en détail, tu réalises que c'est Romain qui a lancé un export de données pour un proof of concept avec un partenaire. Il a copié les données sur un Google Drive partagé avec le partenaire. Des données clients. Sur un Google Drive. Partagé. Avec un tiers. Sans DPA. Sans anonymisation. Tu respires profondément. Ce n'est pas une attaque, mais c'est presque pire : c'est de l'incompétence avec de bonnes intentions."

git commit --allow-empty -m "Le SIEM mûrit, tu deviens le maître du bruit

Après 6 mois, le SIEM est enfin utile. Les alertes sont tombées à 30 par jour, dont environ 5 méritent une investigation. Tu as créé des playbooks de réponse pour chaque type d'alerte. Tu as formé Stéphane à trier les alertes de premier niveau (il grommelle mais il le fait). Le dev junior du programme Security Champions a même écrit un bot Slack qui affiche les alertes critiques en temps réel dans un channel dédié.

La vraie victoire : le SIEM détecte un samedi à 3h du matin une série de tentatives de connexion en brute force sur l'interface d'administration. Le pattern est sophistiqué : les tentatives sont espacées de 30 secondes exactement, depuis des IPs différentes mais toutes dans le même subnet. C'est un vrai attaquant, pas un script kiddie. Le SIEM déclenche automatiquement le blocage des IPs et t'envoie une alerte. Tu investigues le dimanche matin (adieu grasse matinée) et tu confirmes : c'est une attaque ciblée. Ton SIEM l'a stoppée avant qu'elle n'aboutisse. Pour la première fois, tu te dis que les 6 mois de tuning en valaient la peine."

git checkout main

# --------------------------------------------------------------------------
# hotfix/ransomware — diverge après les signaux d'alerte (DIVERGE_POINT_10)
# --------------------------------------------------------------------------
git checkout -b hotfix/ransomware $DIVERGE_POINT_10

git commit --allow-empty -m "Dimanche 2h du matin, le cauchemar commence

Tu es réveillé par ton téléphone qui n'arrête pas de sonner. PagerDuty, puis Stéphane, puis Romain. Les serveurs de production affichent un message : \"YOUR FILES HAVE BEEN ENCRYPTED. Pay 15 BTC within 72 hours or your data will be published. Contact: darkr3ckon@proton.me\". 15 BTC, soit environ 450K€ au cours actuel. Tu t'habilles en 30 secondes, tu ouvres ton laptop, et tu te connectes au VPN (il coupe après 20 minutes, évidemment). Le dashboard de monitoring est un sapin de Noël rouge. 80% des serveurs de production sont chiffrés.

Tu appelles Stéphane : \"Les backups !\" Silence. \"Stéphane, les backups, elles sont où ?\" Un long soupir. \"Sur le NAS.\" \"Quel NAS ?\" \"Le NAS du datacenter.\" \"Le NAS qui est sur le même réseau que la prod ?\" Un silence encore plus long. \"Oui.\" Tu vérifies. Les backups sont chiffrées aussi. Toutes. Les trois derniers mois de backups quotidiennes. Chiffrées. Tu t'assois sur le bord de ton lit. Tu regardes le plafond. Tu penses très fort à ta clause de non-responsabilité dans ton contrat de travail."

git commit --allow-empty -m "Le comité de crise, ou la panique organisée

Lundi 6h du matin. Tu as monté un comité de crise : toi, Romain, Stéphane, Thomas, Amira, et le directeur financier. Thomas est blanc comme un linge : \"On peut payer ?\" Tu expliques que payer ne garantit rien et que ça finance le crime organisé. Le directeur financier est blanc aussi, mais pour d'autres raisons : \"450K€ ?!\" Amira calcule les obligations RGPD : notification CNIL sous 72h (le chrono a commencé dimanche à 2h), notification individuelle des personnes concernées si risque élevé. Romain est au téléphone avec AWS pour comprendre l'étendue des dégâts.

Tu actives le plan de réponse à incident. Tu contactes un prestataire de réponse à incident (un CERT privé que tu avais identifié \"au cas où\" lors de ton arrivée). Ils arrivent dans 4 heures. En attendant, tu isoles tout : tu coupes les connexions entre les systèmes, tu révoques tous les tokens API, tu changes tous les mots de passe de service. Les clients ne peuvent plus se connecter. Le support est submergé. Les réseaux sociaux commencent à bruiter. Un journaliste tech envoie un mail à la communication : \"Nous avons des informations selon lesquelles NexaFlow a subi une cyberattaque. Pouvez-vous confirmer ?\" Thomas te regarde. Tu lui dis : \"Ne dis rien pour l'instant. Laisse Amira gérer la comm.\""

git commit --allow-empty -m "L'analyse forensique, ou la découverte de la porte d'entrée

Le CERT privé arrive. Deux experts qui ont vu ça cent fois et qui ont cette sérénité professionnelle des gens qui travaillent dans la catastrophe. En 6 heures, ils identifient le vecteur d'entrée : un serveur Jenkins exposé sur Internet avec des credentials par défaut (admin/admin). Oui. Admin/admin. Ce serveur Jenkins existait depuis 2020 et avait été \"oublié\" lors de la migration vers le CI/CD cloud. Il tournait sur un vieux serveur virtuel que personne ne monitorait. L'attaquant l'a trouvé via un scan Shodan, s'est connecté, a pris le contrôle du serveur, et de là a pivoté vers le réseau interne.

Tu regardes Romain. Romain regarde ses pieds. \"Je pensais qu'on l'avait décommissionné.\" Stéphane : \"C'est pas moi qui gère Jenkins, c'est les devs.\" Les devs : \"On pensait que Stéphane l'avait arrêté.\" Personne ne gère Jenkins. Jenkins gère Jenkins. Depuis 3 ans. Le CERT identifie que l'attaquant était dans le système depuis 2 semaines, se déplaçant latéralement, escaladant les privilèges, et exfiltrant des données avant de chiffrer. 2 semaines pendant lesquelles personne n'a rien vu. Ton SIEM avait généré des alertes, noyées dans les faux positifs."

git commit --allow-empty -m "La restauration, ou pourquoi il faut tester ses backups

Les backups sur le NAS sont mortes. Mais — et c'est le seul rayon de lumière dans cette nuit — tu avais insisté, il y a 3 mois, pour mettre en place un backup cloud déconnecté sur un bucket S3 avec versioning et Object Lock (écriture une fois, suppression impossible). Thomas avait failli le refuser (\"trop cher\", 200€ par mois). Ce backup existe et n'a pas été touché par le ransomware. Sauf qu'il n'a jamais été testé. Personne ne sait si la restauration fonctionne.

Tu lances la restauration mardi à 14h. La première tentative échoue : le format de backup n'est pas compatible avec la nouvelle version du moteur de base de données (upgradé entre-temps sans mettre à jour la procédure de backup). Stéphane passe 8 heures à trouver un workaround. Deuxième tentative : la base de données se restaure mais il manque les 48 dernières heures (le backup cloud est quotidien, pas en temps réel). Ces 48 heures représentent 3000 transactions clients. Tu les récupères partiellement grâce aux logs applicatifs (ceux que tu avais mis en place pour le SIEM — comme quoi). Mercredi 22h, 80% des services sont restaurés. Jeudi midi, tout est en ligne. Les 48h de données manquantes seront recréées manuellement par le support pendant les 2 semaines suivantes."

git commit --allow-empty -m "Les conséquences, ou le prix de la leçon

Le bilan du ransomware : 4 jours de service dégradé, 48h de données perdues, 150K€ de coûts directs (CERT, heures supplémentaires, communication de crise), une notification CNIL, 12000 emails de notification aux clients, un article dans la presse tech, et une perte de confiance qui prendra des mois à reconstruire. Personne n'a payé la rançon. L'attaquant n'a jamais recontacté.

Thomas convoque un board extraordinaire. Pour la première fois, le mot \"budget sécurité\" est prononcé sans grimace. Tu obtiens le triple de ton budget annuel. Tu recrutes 2 personnes en sécurité opérationnelle. Tu mets en place des backups 3-2-1 (3 copies, 2 supports différents, 1 hors site et hors réseau). Tu décommissionnes 14 services \"oubliés\" exposés sur Internet (le scan en révèle 14, pas juste Jenkins). Tu mets en place un vrai programme de gestion des vulnérabilités.

La phrase que tu répétais depuis des mois — \"ce n'est pas une question de si, mais de quand\" — est devenue la phrase que Thomas répète dans toutes ses interventions. Ça t'aurait fait plaisir si les circonstances n'étaient pas aussi tristes."

git checkout main

# --------------------------------------------------------------------------
# hotfix/fuite-donnees — diverge après le shadow IT (DIVERGE_POINT_2)
# --------------------------------------------------------------------------
git checkout -b hotfix/fuite-donnees $DIVERGE_POINT_2

git commit --allow-empty -m "Un samedi matin, un tweet t'arrête le coeur

Tu scrolles Twitter (enfin X, mais tu refuses de l'appeler comme ça) un samedi matin en buvant ton café. Un tweet d'un compte infosec avec 50K followers : \"Anyone seen this? Full customer database dump from @NexaFlow on a public GitHub repo. Emails, phone numbers, billing addresses. 47K records. #databreach #infosec\". Ton café refroidit instantanément. Tu vérifies. C'est vrai. Un repo GitHub public, créé il y a 36 heures, contient un fichier customers_export_prod_20240315.sql de 2.3 Go. C'est un dump complet de la table clients.

Tu vérifies l'auteur du repo. Le pseudo GitHub est \"nexaflow-julie\". C'est le compte personnel de Julie, la dev senior. Le repo s'appelle \"data-migration-scripts\". Julie a poussé le dump de la BDD sur son repo personnel pour \"tester un script de migration\". Sur un repo public. Parce que les repos privés étaient limités sur son plan gratuit. 47 000 clients avec noms, emails, numéros de téléphone, adresses de facturation, et les 4 derniers chiffres de leur carte bancaire. Tu appelles Julie. Elle ne comprend pas le problème : \"Mais c'est juste pour tester, personne ne va chercher ça.\""

git commit --allow-empty -m "La gestion de crise, ou 72 heures chrono

Tu es en mode automatique. Tu connais la procédure par coeur (tu l'as vécu 3 fois à l'ANSSI). Étape 1 : contenir. Tu demandes à Julie de supprimer immédiatement le repo. Elle le fait, mais tu sais que c'est inutile — le dump a été forké 7 fois et est probablement déjà sur des forums. Étape 2 : évaluer. Tu analyses le contenu exact du dump. Heureusement, les mots de passe sont hashés (bcrypt, au moins ça). Mais les données personnelles sont en clair. Étape 3 : notifier. Tu appelles Amira un samedi à 9h. Elle répond avec la voix de quelqu'un qui sait que les appels du samedi ne sont jamais de bonnes nouvelles.

La CNIL doit être notifiée dans les 72h si la fuite présente un risque pour les personnes concernées. Des noms + emails + adresses + derniers chiffres de CB = risque élevé. Amira rédige la notification pendant que tu rédiges la communication client. Thomas veut \"minimiser\". Tu lui expliques qu'on ne minimise pas une fuite de données, on la traite avec transparence sous peine de sanctions RGPD. Il n'aime pas mais il accepte. Romain est furieux contre Julie, mais tu lui rappelles que c'est un problème systémique, pas individuel : il n'y avait aucune politique d'utilisation des données de production à des fins de test."

git commit --allow-empty -m "La notification client, ou l'art de dire \"on a merdé\" poliment

Tu rédiges le mail aux 47 000 clients. Quinze versions avant d'arriver au bon ton : honnête sans être alarmiste, factuel sans être froid, rassurant sans être condescendant. Le résultat : \"Nous avons identifié un incident de sécurité affectant certaines données personnelles. Voici les données concernées, les mesures prises, et les actions recommandées.\" Tu recommandes aux clients de surveiller leurs relevés bancaires (même si seuls les 4 derniers chiffres ont fuité, tu préfères être prudent) et de se méfier des tentatives de phishing.

Le mail part un lundi à 8h. À 8h15, le support est submergé. Les réseaux sociaux s'enflamment. Un client influenceur poste : \"NexaFlow stocke nos CB en clair et les publie sur Internet.\" C'est faux (les CB ne sont pas en clair et ce ne sont que les 4 derniers chiffres), mais la nuance se perd dans le bruit. Le hashtag #NexaFlowLeak trending pendant 4 heures. Le taux de churn triple dans la semaine. Le directeur commercial te regarde avec des yeux qui disent \"tout est de ta faute\" alors que c'est littéralement le contraire."

git commit --allow-empty -m "Les conséquences, ou le long chemin de la rédemption

Bilan de la fuite : 47K clients impactés, 1200 résiliations directes, un article dans Le Monde (\"Une start-up française expose les données de ses clients sur Internet\"), une notification CNIL, et 6 mois plus tard, une sanction de 150K€ (réduite grâce à ta coopération rapide et transparente — ça aurait pu être le double). Julie a été recadrée mais pas licenciée — tu t'es battu pour elle parce que le vrai problème c'est le système, pas la personne.

Les mesures correctives : interdiction d'utiliser des données de production en dehors de la production (un système d'anonymisation automatique est mis en place pour les tests), scan automatique des repos GitHub publics des employés (oui, c'est intrusif, mais après ça...), formation obligatoire sur la manipulation des données sensibles, et mise en place de Data Loss Prevention (DLP) sur les canaux de sortie de données. Le plus ironique : le script de migration que Julie testait ne fonctionnait même pas. Elle avait poussé le dump \"en attendant de corriger le script\" et n'était jamais revenue dessus."

git checkout main

# --------------------------------------------------------------------------
# hotfix/phishing-reel — diverge après la formation phishing (DIVERGE_POINT_5)
# --------------------------------------------------------------------------
git checkout -b hotfix/phishing-reel $DIVERGE_POINT_5

git commit --allow-empty -m "Un vrai phishing réussit, et c'est pas un exercice

L'ironie est cosmique. Deux semaines après ta campagne de faux phishing (celle où 43% de l'entreprise a cliqué), un vrai phishing réussit. Et pas sur n'importe qui : sur le comptable, Bernard. Bernard reçoit un mail du \"CEO\" (spoofing basique avec un domaine nexafl0w.com) qui dit : \"Bernard, j'ai besoin que tu fasses un virement urgent de 45 000€ au fournisseur ci-joint. C'est confidentiel, ne parle de ça à personne. Cordialement, Thomas.\" Bernard ne questionne pas. Il ne vérifie pas. Il ne t'appelle pas. Il fait le virement. Puis il va déjeuner.

Tu l'apprends le lendemain, quand le vrai Thomas demande au service comptable pourquoi il y a un virement de 45K€ vers un compte en Lituanie. Bernard explique : \"Mais c'est toi qui m'as demandé !\" Thomas : \"Je n'ai jamais envoyé ça.\" Bernard montre le mail. Thomas regarde. Tu regardes. Le mail vient de thomas@nexafl0w.com (avec un zéro au lieu du o). L'objet est \"Virement urgent — confidentiel\". La signature est un copier-coller de la vraie signature de Thomas. Bernard ne comprend toujours pas le problème : \"Mais ça vient de ton adresse !\""

git commit --allow-empty -m "L'enquête et la tentative de récupération des 45K€

Tu contactes immédiatement la banque de NexaFlow. Le virement a été effectué hier à 13h47. Il est 10h du matin. Tu as environ 2 heures avant que les fonds ne soient transférés hors du compte lituanien (les escrocs agissent vite). La banque te passe de service en service. Tu expliques la situation 4 fois. On te dit qu'un \"recall\" de virement SEPA est possible mais \"pas garanti\". Tu remplis un formulaire. Tu envoies un mail. Tu appelles la ligne d'urgence fraude. L'attente est de 25 minutes. Tu écoutes du Vivaldi en boucle en te demandant si c'est comme ça que finissent toutes les carrières en cybersécurité.

En parallèle, tu déposes plainte en ligne sur la plateforme THESEE du gouvernement. Tu contactes aussi le CERT-FR parce que le mode opératoire ressemble à une campagne organisée (un collègue CISO dans un autre secteur t'avait signalé un cas similaire le mois dernier). L'enquête sur le mail montre que les attaquants avaient fait leurs devoirs : ils connaissaient le nom du comptable, le format habituel des mails du CEO, et les montants typiques des virements fournisseurs. Soit c'est une info publique (LinkedIn + factures en ligne), soit quelqu'un a parlé."

git commit --allow-empty -m "Les 45K€ sont perdus, Bernard est dévasté

La banque te rappelle le lendemain. Le recall a échoué. Les fonds ont été transférés vers un second compte, puis un troisième, avant de disparaître dans un brouillard de crypto. Les 45K€ sont perdus. L'assurance cyber de NexaFlow (que tu avais fait souscrire 2 mois plus tôt — dieu merci) couvre le sinistre avec une franchise de 5K€. Mais l'argent n'est pas le vrai problème.

Bernard est dévasté. Il ne comprend pas comment il s'est fait avoir. Tu t'assois avec lui et tu lui montres les indices : le domaine différent, l'absence de signature DKIM, le ton inhabituel (\"confidentiel, ne parle de ça à personne\" — un red flag classique), l'urgence artificielle. Bernard pleure presque : \"Mais je voulais bien faire, le patron m'a demandé...\" Tu ne peux pas lui en vouloir. C'est un comptable compétent de 55 ans qui fait confiance à sa hiérarchie. Le vrai coupable c'est un système qui permet à un mail de déclencher un virement de 45K€ sans double validation. Tu te retiens de dire \"je l'avais dit\" parce que tu l'avais dit, dans un mémo envoyé un mois plus tôt, recommandant une double signature pour tout virement supérieur à 10K€. Le mémo était \"en cours de validation\"."

git commit --allow-empty -m "Les mesures post-incident et la fin des virements freestyle

Tu mets en place immédiatement : double signature pour tout virement supérieur à 5K€, validation vocale obligatoire pour les demandes de virement par mail, formation spécifique de l'équipe comptable aux arnaques au président, implémentation de DMARC/DKIM/SPF sur le domaine NexaFlow pour réduire le spoofing, et un gros bandeau rouge dans les mails externes qui arrive dans les boîtes : \"⚠ CE MAIL PROVIENT DE L'EXTÉRIEUR - VÉRIFIEZ L'EXPÉDITEUR\".

Le plus efficace : tu mets en place une règle simple — toute demande \"urgente\" et \"confidentielle\" doit être considérée comme suspecte par défaut. Si le CEO t'envoie un mail disant \"fais ça vite et n'en parle à personne\", tu en parles à tout le monde. Thomas valide cette règle publiquement : \"Si je vous demande de garder un secret par mail, c'est que ce n'est pas moi.\" Bernard affiche cette phrase au-dessus de son écran. Trois mois plus tard, il détectera une seconde tentative d'arnaque et la signalera immédiatement. Tu es fier de lui."

git checkout main

# --------------------------------------------------------------------------
# hotfix/cle-api-publique — diverge après secrets dans le code (DIVERGE_POINT_6)
# --------------------------------------------------------------------------
git checkout -b hotfix/cle-api-publique $DIVERGE_POINT_6

git commit --allow-empty -m "Un mail d'AWS qui fait tomber le café des mains

Tu reçois un mail d'AWS à 7h du matin : \"Unusual activity detected on your account. Your current month-to-date charges are \$28,473.12, which is 4,200% above your typical usage.\" Vingt-huit mille dollars. Tu n'as même pas fini ta première gorgée de café. Tu te connectes à la console AWS. Le dashboard de facturation est un cauchemar : des centaines d'instances EC2 de type p3.8xlarge (les plus grosses, avec GPU) ont été lancées dans 6 régions différentes. Elles minent de la cryptomonnaie. Depuis 3 jours.

Tu remontes la trace. Les instances ont été lancées avec les credentials du compte root AWS. Le même compte root dont le mot de passe était \"thomas1234\" et dont la clé d'accès (ACCESS_KEY + SECRET_KEY) était commitée en dur dans le repo GitHub de NexaFlow. Le repo est privé, certes, mais la clé avait été copiée dans un Gist public par un dev il y a 8 mois pour \"débugger un truc\". Le Gist est indexé par Google. N'importe qui tapant \"AKIA\" + \"nexaflow\" dans Google trouvait la clé. Et quelqu'un l'a trouvée."

git commit --allow-empty -m "La course contre la montre pour arrêter l'hémorragie

Tu as exactement deux priorités : arrêter les instances de minage et révoquer les clés compromises. Dans cet ordre. Tu te connectes à AWS, tu navigues vers EC2 dans chaque région. Oregon : 47 instances. Irlande : 38 instances. Singapour : 52 instances. São Paulo : 33 instances. Sydney : 28 instances. Tokyo : 41 instances. 239 instances de minage au total. Tu commences à les terminer une par une — non, c'est trop long. Tu écris un script bash en tremblant qui boucle sur toutes les régions et termine toutes les instances de type p3. Tu le lances. Ça prend 15 minutes. Le compteur de facturation arrête de monter.

Ensuite, les clés. Tu révoques immédiatement la clé d'accès du compte root. Tu révoques tous les tokens temporaires. Tu changes le mot de passe root. Tu actives le MFA sur le compte root (oui, le compte root n'avait pas de MFA — tu avais un ticket ouvert pour ça depuis 3 mois, bloqué par Romain qui \"n'avait pas le temps\"). Tu vérifies les autres services : pas de ressources suspectes sur S3, RDS, ou Lambda. Le minage était la seule activité. C'est presque rassurant."

git commit --allow-empty -m "La facture de 28K€ et la négociation avec AWS

La facture AWS affiche 28 473,12\$. Thomas manque de s'évanouir. Tu contactes le support AWS. C'est ton moment de vérité : AWS a une politique informelle de goodwill credit pour les cas de compromission de clés, MAIS seulement si tu peux démontrer que les mesures correctives ont été prises. Tu rédiges un rapport détaillé : comment la clé a fuité, quand tu l'as détecté, les mesures de remédiation, et les contrôles mis en place pour que ça ne se reproduise pas.

AWS répond après 5 jours (les plus longs de ta carrière). Ils acceptent de créditer 80% de la facture. NexaFlow ne paiera \"que\" 5 694,62\$, soit environ 5 300€. Thomas est soulagé mais furieux : \"Qui a mis la clé en public ?\" Tu enquêtes. Le Gist a été créé par un dev freelance qui a travaillé 3 mois chez NexaFlow et qui est parti depuis 6 mois. Personne n'a pensé à révoquer les clés qu'il utilisait. Personne n'a vérifié ses repos publics. Personne ne savait qu'il avait accès au compte root. Tu ajoutes \"offboarding des prestataires\" à ta liste de choses à créer, une liste qui commence à ressembler à l'encyclopédie Universalis."

git commit --allow-empty -m "Les mesures post-incident et la fin des clés en dur

Le post-mortem révèle une chaîne de défaillances : clé root utilisée par les devs (au lieu de comptes IAM individuels), pas de budget alerting configuré sur AWS, pas de détection de secrets dans le CI/CD, pas de rotation des clés, et un processus d'offboarding des prestataires inexistant. Tu mets en place : des comptes IAM individuels pour chaque dev avec le principe du moindre privilège, un budget alerting AWS (alerte à 150% du budget mensuel), un scan de secrets dans le pipeline CI/CD (git-secrets + truffleHog), la rotation automatique des clés tous les 90 jours via AWS Secrets Manager, et un processus d'offboarding qui inclut la révocation de TOUS les accès dans les 24h.

Tu organises aussi une session \"post-mortem blameless\" avec toute l'équipe technique. L'objectif : comprendre comment c'est arrivé sans pointer du doigt. Romain est sceptique (\"c'est quand même la faute du freelance\"), mais tu insistes : si le système permet à un seul humain de causer 28K€ de dégâts, le problème est le système. Stéphane, étonnamment, est le plus réceptif : \"J'ai des trucs similaires sur mes serveurs, on devrait vérifier.\" Tu vérifies. Il a 3 clés SSH de personnes qui n'ont plus travaillé chez NexaFlow depuis 2 ans. Tu les supprimes en essayant de ne pas crier."

git checkout main

# --------------------------------------------------------------------------
# fix/security-by-design — diverge après RGPD (DIVERGE_POINT_8)
# --------------------------------------------------------------------------
git checkout -b fix/security-by-design $DIVERGE_POINT_8

git commit --allow-empty -m "Le déclic — la sécu ne doit plus être un add-on

Après des mois de lutte, tu réalises que tu te bats contre la culture, pas contre la technologie. Tu peux mettre tous les outils du monde, si les gens voient la sécurité comme un obstacle, tu perdras toujours. Tu décides de changer d'approche : au lieu d'imposer la sécu APRÈS le développement, tu vas l'intégrer DANS le développement. Le concept s'appelle \"Shift Left\" ou \"Security by Design\". Romain lève un sourcil : \"Ça veut dire que mes devs doivent faire de la sécu ?\" Non, Romain. Ça veut dire que la sécu doit être aussi naturelle que les tests unitaires. Il te regarde avec l'air de quelqu'un dont les devs ne font pas non plus de tests unitaires."

git commit --allow-empty -m "La mise en place du DevSecOps pipeline

Tu conçois un pipeline DevSecOps en 4 étapes. Étape 1 : analyse statique du code (SAST) avec Semgrep — chaque pull request est scannée automatiquement, les failles de sécurité bloquent le merge. Étape 2 : scan des dépendances avec Snyk — les librairies vulnérables sont flaggées avec leur correctif. Étape 3 : scan des secrets avec git-secrets — plus aucune clé API ne passe en production. Étape 4 : analyse dynamique (DAST) sur l'environnement de staging — un scan ZAP automatique après chaque déploiement.

Le premier jour du pipeline, 40% des pull requests sont bloquées. Les devs sont furieux. \"C'est n'importe quoi, c'est un faux positif !\" Parfois oui, parfois non. Tu passes la première semaine à trier les vrais problèmes des faux positifs et à configurer les exceptions. La deuxième semaine, 25% sont bloquées. La troisième, 15%. Les devs commencent à intégrer les bonnes pratiques dès l'écriture du code. Pas par conviction — par flemme de corriger après coup. La flemme est le moteur le plus puissant de l'humanité, et tu comptes bien l'exploiter."

git commit --allow-empty -m "Les threat modeling sessions, ou quand les devs découvrent l'attaquant

Tu introduis les \"threat modeling sessions\" : avant de coder une nouvelle feature, l'équipe passe 1h à réfléchir aux scénarios d'attaque possibles. \"Si quelqu'un voulait exploiter cette feature, comment ferait-il ?\" Les premières sessions sont laborieuses. Les devs ne pensent pas comme des attaquants. Tu leur apprends : \"Imaginez que vous êtes un ado de 17 ans à Bucarest avec beaucoup de temps libre et un accès Internet.\" (La référence à Andrei le bug hunter fait rire ceux qui étaient là).

La révélation vient lors de la session sur la nouvelle feature d'export de données. Un dev réalise : \"Attends, si quelqu'un change l'ID dans l'URL, il peut exporter les données d'un autre client ?\" Silence. \"C'est un IDOR, non ?\" Tu souris. C'est la première fois qu'un dev identifie une faille AVANT de l'écrire. Le dev corrige le design. La feature sort sécurisée dès le départ. Pas de hotfix, pas de patch, pas de nuit blanche. Juste 1h de réflexion en amont. Tu vis pour ces moments."

git commit --allow-empty -m "La Security Guild et la culture qui change

Tu crées une \"Security Guild\" — un espace informel où les devs peuvent partager des découvertes, des articles, des CTF (Capture The Flag). C'est un channel Slack + un meetup mensuel avec pizza. Le premier meetup attire 4 personnes (dont Maxence, qui a maintenant des accès restreints et un vrai intérêt pour la sécu). Le deuxième en attire 8. Le troisième, 15. Au sixième, Romain vient. Il pose des questions. Il est sincèrement intéressé. Tu manques de tomber de ta chaise.

Le signe que la culture change : un dev envoie un message sur #general : \"Hey, je viens de trouver une faille dans le code de la feature de facturation, j'ai créé un ticket et un fix, review welcome.\" Personne ne se moque. Personne ne blame. Un autre dev répond : \"Nice catch 👍\" Romain réagit avec un emoji fusée. Stéphane réagit avec un pouce (son premier emoji en 5 ans de Slack). Tu réalises que tu es en train de gagner. Pas la guerre — on ne gagne jamais la guerre en cybersécurité — mais une bataille importante."

git commit --allow-empty -m "Le Security by Design comme avantage compétitif

Six mois après le pivot DevSecOps. Les métriques parlent : le nombre de vulnérabilités en production a baissé de 73%. Le temps de correction d'une faille est passé de 3 semaines à 3 jours. Le coût moyen d'une correction a été divisé par 5 (corriger en amont coûte 10x moins qu'en production, et 100x moins qu'après un incident). Les développeurs ne râlent plus contre la sécurité — certains en sont même fiers.

Thomas, en bon CEO, a flairé l'opportunité commerciale : \"On peut pas en faire un argument de vente ?\" Pour une fois, tu es d'accord. NexaFlow commence à communiquer sur sa démarche \"Security by Design\" dans ses réponses aux appels d'offres. Deux clients enterprise signent en citant la maturité sécurité comme facteur différenciant. Romain présente le pipeline DevSecOps dans une conférence tech (il dit \"on\" en parlant de la démarche, comme si c'était son idée — tu laisses courir, l'important c'est le résultat). La sécurité n'est plus un coût. C'est un investissement. Et pour une fois, même le DAF est d'accord."

git checkout main

# --------------------------------------------------------------------------
# fix/demission-desillusion — diverge après les signaux d'alerte (DIVERGE_POINT_10)
# --------------------------------------------------------------------------
git checkout -b fix/demission-desillusion $DIVERGE_POINT_10

git commit --allow-empty -m "La goutte d'eau — le budget sécu est divisé par deux

Tu sors du comité de direction avec le goût amer de la défaite. Thomas vient de t'annoncer que le budget sécurité sera réduit de 50% au prochain trimestre. Raison : \"On doit prioriser la croissance, la sécu c'est important mais on a déjà fait le plus gros du travail.\" Le plus gros du travail. Tu repenses aux 127 risques critiques identifiés, dont 89 sont encore ouverts. Tu repenses aux accès de Julie jamais révoqués. Au Jenkins oublié. Au mot de passe root sur Slack. Tu as passé 10 mois à construire un mur de sable et on te dit que la marée ne viendra pas.

Romain n'aide pas. En réunion, il a dit : \"On est une boîte tech, pas une banque. On ne peut pas tout bloquer au nom de la sécu.\" Les devs ont applaudi. Thomas a hoché la tête. Amira t'a regardé avec compassion. Stéphane a quitté la réunion pour \"aller rebooter un serveur\" (sa manière de dire qu'il est d'accord avec toi mais qu'il ne veut pas le dire). Tu rentres chez toi ce soir-là en te demandant pourquoi tu as quitté l'ANSSI."

git commit --allow-empty -m "Le burnout silencieux — tu absorbes le stress de toute l'entreprise

Les semaines suivantes sont un brouillard. Tu travailles 12 heures par jour. Tu te réveilles à 3h du matin en pensant à cette règle firewall que tu n'as pas vérifiée. Tu scrolles les alertes SIEM en mangeant. Tu vérifies les scans de vulnérabilités sous la douche (ton téléphone dans un sac congélation, ta dignité aux oubliettes). Chaque notification PagerDuty te fait monter le rythme cardiaque à 120.

Le médecin du travail te dit que tu montres des signes de burnout. Tu ris : \"C'est pas du burnout, c'est de la vigilance.\" Il ne rit pas. Il te donne le numéro d'un psychologue. Tu ne l'appelles pas. Tu continues. Tu portes le poids de la sécurité de 200 personnes, de 47 000 clients, d'une infrastructure qui tient avec du scotch numérique. Personne ne te dit merci quand tout va bien. Tout le monde te blame quand ça plante. Tu es le parapluie invisible : tant qu'il ne pleut pas, personne ne voit ton utilité."

git commit --allow-empty -m "La lettre de démission — tu choisis ta santé

Tu rédiges ta lettre de démission un dimanche soir. Trois paragraphes. Professionnel, factuel, sans amertume (enfin, tu essaies). Tu la donnes à Thomas le lundi matin. Il est surpris : \"Mais pourquoi ? Tu fais un super boulot !\" Tu lui expliques calmement : le budget coupé, les risques non traités, les alertes ignorées, la solitude du CISO dans une organisation qui voit la sécurité comme un frein. Thomas essaie de te retenir : augmentation, titre de VP, budget restauré. Tu refuses. C'est trop tard. Le problème n'est pas le budget ou le titre. Le problème est culturel, et la culture ne se change pas par décret.

Amira vient te voir dans l'après-midi. Elle comprend. Elle aussi pense à partir. \"La compliance dans une boîte qui ne veut pas être compliant, c'est comme être arbitre dans un match sans règles.\" Stéphane, étonnamment, te prend à part : \"Tu avais raison sur tout. Personne ne t'a écouté. C'est comme ça dans toutes les boîtes.\" C'est la chose la plus longue que Stéphane t'ait jamais dite."

git commit --allow-empty -m "La suite — le conseil, la liberté, et la petite voix qui dit \"je te l'avais dit\"

Tu quittes NexaFlow un vendredi. Pot de départ rapide, poignées de main, promesses de rester en contact (tu ne resteras pas en contact). Le lundi suivant, tu commences ta nouvelle vie : consultant indépendant en cybersécurité. Ton premier client est une PME de 50 personnes dont le mot de passe admin est \"admin\". Tu souris. On recommence.

Six mois plus tard, tu apprends par LinkedIn que NexaFlow a subi un incident de sécurité majeur. Un ransomware. Les détails sont flous mais tes anciens collègues te contactent en off : c'est le Jenkins oublié que tu avais flaggé dans ton dernier rapport, celui qu'on n'a jamais décommissionné. Tu ressens un mélange de tristesse et de validation. Tu avais raison. Tu as toujours raison. C'est le fardeau du CISO : avoir raison est une malédiction quand personne n'écoute. Tu écris un post LinkedIn sobrement intitulé \"Pourquoi les CISO quittent\" qui fait 50K vues. Thomas ne like pas. Romain non plus. Mais 500 CISO à travers le monde te remercient en commentaire. Tu n'es pas seul. Tu n'as jamais été seul. Vous êtes une armée silencieuse de Cassandre numériques."

git checkout main

# --------------------------------------------------------------------------
# fix/acquisition-sauvee — diverge après ISO 27001 (DIVERGE_POINT_9)
# --------------------------------------------------------------------------
git checkout -b fix/acquisition-sauvee $DIVERGE_POINT_9

git commit --allow-empty -m "Le coup de fil inattendu — un grand groupe veut racheter NexaFlow

Thomas te convoque un matin avec un air de conspirateur. \"C'est confidentiel\", dit-il en fermant la porte. Un grand groupe du CAC 40, DataCorp, veut acquérir NexaFlow. Valorisation : 50 millions d'euros. Thomas tremble d'excitation. Mais DataCorp a une condition : une due diligence complète, incluant un audit de sécurité informatique. \"Leur CISO veut voir notre posture sécu\", dit Thomas. \"C'est quoi notre posture sécu ?\" Tu hésites entre rire et pleurer. \"Tu veux la version optimiste ou la version réaliste ?\" Thomas : \"La version qui nous fait acheter.\""

git commit --allow-empty -m "La due diligence sécu — DataCorp envoie ses auditeurs

DataCorp envoie trois auditeurs. Leur lead s'appelle Catherine. Catherine est l'antithèse de Marc l'auditeur SOC2 : elle sourit, elle est polie, et elle est dix fois plus terrifiante. Parce que Catherine ne cherche pas des cases à cocher — elle cherche la réalité. \"Montrez-moi votre dernier incident de sécurité\", demande-t-elle. Tu montres la fuite de données (Julie, le dump sur GitHub). Catherine hoche la tête : \"Comment avez-vous réagi ?\" Tu montres le post-mortem, les mesures correctives, les contrôles mis en place. Catherine note : \"Bon. Et votre programme de gestion des vulnérabilités ?\" Tu montres le bug bounty, les scans SAST/DAST, le SIEM. Catherine est... impressionnée ? \"C'est rare pour une boîte de votre taille.\""

git commit --allow-empty -m "Le rapport d'audit — le bon, la brute, et le truand

Le rapport d'audit de Catherine arrive deux semaines plus tard. 30 pages. Tu le lis en premier (Thomas te l'a envoyé en te suppliant de \"trouver les trucs positifs\"). Le rapport est nuancé. Les points positifs : programme de sécurité structuré, pipeline DevSecOps, SIEM opérationnel, programme de sensibilisation, réponse à incident documentée et testée, certification SOC2 en cours. Les points négatifs : dette technique de sécurité significative, infrastructure legacy non sécurisée, gouvernance des accès encore immature, pas de site de repli, et \"une dépendance forte sur le CISO qui porte l'essentiel de la charge opérationnelle\" (tu lis : \"si le CISO part, tout s'effondre\").

La recommandation de Catherine : \"NexaFlow présente un niveau de maturité sécurité supérieur à la moyenne des entreprises de taille comparable, avec des fondations solides mais des chantiers encore en cours. L'acquisition est recommandée sous réserve d'un plan d'investissement sécurité post-acquisition de 500K€ sur 18 mois.\" Thomas ne retient qu'une chose : \"recommandée\". Il saute de joie. Tu retiens : 500K€ de budget sécu. C'est plus que tout ce que tu as eu en un an."

git commit --allow-empty -m "La négociation — la sécu comme levier de valorisation

L'avocat de DataCorp envoie une liste de conditions suspensives. Parmi elles : obtention de la certification ISO 27001 dans les 12 mois post-acquisition, mise en conformité totale RGPD, et recrutement d'une équipe sécurité de 3 personnes minimum. Thomas vient te voir : \"Si on n'a pas ces trucs, ils baissent la valorisation de 15%. C'est 7,5 millions.\" Sept millions et demi. Soudain, la sécurité a un prix. Et ce prix est très concret.

Tu négocies avec DataCorp : tu présentes la roadmap sécu que tu avais rédigée six mois plus tôt (celle que Thomas avait mise en \"backlog\"). Catherine la valide comme \"réaliste et ambitieuse\". Tu montres les progrès déjà réalisés. Tu montres les certifications en cours. Tu montres que l'investissement sécu n'est pas une dépense mais une protection de la valeur. L'avocat de NexaFlow ajoute une clause : le budget sécu de 500K€ sera financé par DataCorp post-acquisition. Thomas accepte tout. Il signerait n'importe quoi pour 50 millions."

git commit --allow-empty -m "La signature et l'ironie finale

L'acquisition est signée. 50 millions. Pas de décote. Le rapport de Catherine et ta roadmap sécu ont sauvé 7,5 millions de valorisation. Thomas fait un discours émouvant devant toute l'entreprise : \"Cette acquisition est le fruit du travail de toute l'équipe.\" Il te regarde et ajoute : \"Et en particulier de notre CISO, qui a construit une culture de sécurité qui a convaincu DataCorp de notre sérieux.\" Les gens applaudissent. Romain applaudit. Stéphane lève son mug de café, c'est son standing ovation.

L'ironie : le budget sécu que tu demandais depuis un an et que Thomas refusait (200K€), c'est DataCorp qui va le mettre. Cinq fois plus. L'investissement que Thomas jugeait \"excessif\" est celui qui a permis l'acquisition. La sécurité n'était pas un frein à la croissance — c'était la condition de la croissance. Tu te permets un sourire. Puis tu ouvres ton laptop et tu regardes les 89 risques critiques encore ouverts. 500K€, c'est bien. Mais il y a du boulot. Il y a toujours du boulot."

git checkout main

# --------------------------------------------------------------------------
# feature/pentest-desastre — diverge après l'audit initial (DIVERGE_POINT_1)
# --------------------------------------------------------------------------
git checkout -b feature/pentest-desastre $DIVERGE_POINT_1

git commit --allow-empty -m "Tu commandes un pentest, Romain pense que c'est un pen test (test de stylo)

Trois semaines après ton arrivée, tu décides de commander un test d'intrusion externe. Tu veux un état des lieux objectif de la surface d'attaque. Tu en parles à Romain. \"Un pentest ? C'est quoi, on teste la résistance de nos serveurs ?\" Pas tout à fait, Romain. Tu expliques qu'une équipe de hackers éthiques va essayer de pénétrer dans les systèmes de NexaFlow, exactement comme le ferait un vrai attaquant. Romain pâlit légèrement : \"Et s'ils cassent quelque chose ?\" C'est un peu le but, Romain.

Tu sélectionnes OffenSec, un cabinet de pentest recommandé par un ancien collègue de l'ANSSI. Le devis : 18K€ pour un test d'intrusion externe (infrastructure + applicatif) sur deux semaines. Thomas négocie à 15K€ parce que \"c'est beaucoup pour laisser des gens pirater notre propre boîte\". Le périmètre est défini : tous les assets exposés sur Internet, l'application principale, les API, et les services annexes. Tu fixes les dates : dans deux semaines. Romain demande s'il peut \"préparer\" les systèmes avant le test. Tu lui expliques que c'est exactement ce qu'il ne faut PAS faire."

git commit --allow-empty -m "Jour 1 du pentest — les pentesteurs ont accès admin en 4 heures

Le pentest commence un lundi à 9h. À 13h, tu reçois un mail de l'équipe OffenSec : \"Nous avons obtenu un accès administrateur à l'application principale. Voulez-vous que nous continuions ou que nous nous arrêtions pour un point d'étape ?\" Quatre heures. Tu fermes ton bureau. Tu appelles la lead pentesteur, Sophia. Elle t'explique calmement : \"On a trouvé un endpoint d'API non authentifié qui retourne les tokens de session actifs. De là, on a récupéré un token admin. C'était assez trivial.\"

\"Assez trivial.\" Ces mots vont te hanter. Tu informes Romain. Il refuse d'y croire : \"C'est impossible, on a un middleware d'authentification partout.\" Tu lui montres le rapport préliminaire. L'endpoint vulnérable est /api/internal/health-check. Un endpoint de monitoring que personne n'a pensé à protéger parce que \"c'est juste un health check\". Sauf que le health check retourne, en mode debug (activé en production depuis 2020), toutes les variables d'environnement du serveur, incluant les tokens de session en mémoire. Romain regarde l'écran en silence. Puis : \"Qui a laissé le mode debug en prod ?\" Personne ne répond. Le commit date de 2019. L'auteur a quitté la boîte."

git commit --allow-empty -m "Le rapport intermédiaire — 47 pages de sueur froide

Fin de la première semaine. Sophia et son équipe t'envoient un rapport intermédiaire. 47 pages. Tu les lis une par une, avec une boule au ventre qui grossit à chaque page. Les trouvailles : 3 vulnérabilités critiques (l'endpoint health-check, une injection SQL sur l'API de recherche, et un bypass d'authentification sur le panel admin), 8 vulnérabilités hautes (SSRF, IDOR, XSS stocké, désérialisation non sécurisée, et 4 autres), 15 vulnérabilités moyennes, et 21 vulnérabilités basses. Total : 47 vulnérabilités. Une par page. Comme si le rapport avait été conçu pour la douleur maximale.

La plus spectaculaire : une SSRF (Server-Side Request Forgery) sur la fonctionnalité d'import d'images qui permet d'accéder au metadata service d'AWS (169.254.169.254) et de récupérer les credentials IAM temporaires du rôle EC2. De là, l'équipe a pu lister les buckets S3, accéder aux backups de base de données, et théoriquement exfiltrer toutes les données clients. Sophia commente : \"C'est une chaîne d'attaque classique, mais elle ne devrait pas fonctionner en 2024.\" Tu transmets le rapport à Romain. Romain ne te parle pas pendant deux jours."

git commit --allow-empty -m "La réunion de restitution, ou le moment où tout le monde comprend

OffenSec vient présenter les résultats en personne. Tu as insisté pour que Thomas et Romain soient présents. Sophia est pédagogue : elle montre les attaques en live, sur un environnement de démonstration. Elle montre comment elle accède aux données clients en 3 clics. Elle montre comment elle peut modifier les factures. Elle montre comment elle peut se créer un compte admin invisible. Le visage de Thomas passe par 5 stades : incrédulité, déni, colère, négociation, et finalement une acceptation résignée.

Romain pose des questions techniques. Bonnes questions. Il est en mode ingénieur, pas en mode défensif. C'est bon signe. Sophia répond patiemment. Elle recommande une remédiation en 3 phases : urgente (les 3 critiques, dans la semaine), prioritaire (les 8 hautes, dans le mois), et planifiée (les 36 restantes, dans le trimestre). Romain demande : \"On a les ressources pour ça ?\" Tu regardes Thomas. Thomas regarde le plafond. \"On va trouver les ressources.\" C'est le moment le plus positif de tes trois premières semaines chez NexaFlow."

git commit --allow-empty -m "La remédiation et le re-test — de 47 failles à 3 (acceptées)

Deux mois plus tard. L'équipe dev a corrigé 44 vulnérabilités sur 47. Les 3 restantes sont des failles de conception architecturale qui nécessitent une refonte majeure — tu les acceptes comme \"risques résiduels\" avec des mesures compensatoires (monitoring renforcé, rate limiting, WAF). Tu commandes un re-test à OffenSec (5K€ supplémentaires — Thomas grimace mais paie). Sophia revient avec son équipe. Cette fois, le test dure la journée complète avant qu'ils ne trouvent un premier point d'entrée (un XSS réfléchi sur une page d'erreur 404 custom). Le rapport de re-test : 5 pages. 2 vulnérabilités moyennes, 1 basse. L'endpoint health-check est protégé. L'injection SQL est corrigée. Le mode debug est désactivé en production.

Sophia te dit en partant : \"C'est rare que les corrections soient aussi rapides et complètes. Votre équipe dev a bien bossé.\" Tu transmets le compliment à Romain. Il sourit — le premier vrai sourire qu'il t'adresse depuis ton arrivée. Tu programmes un pentest annuel. Thomas le budgétise sans négocier le prix (une première). Le rapport initial de 47 pages reste affiché dans ton bureau. Pas pour la honte — pour le rappel. La distance entre \"rien\" et \"correct\" se mesure en volonté, pas en technologie."

git checkout main

echo ""
echo "================================================"
echo "  Livre généré avec succès !"
echo "================================================"
echo ""
echo "Statistiques :"
echo "  - Commits sur main : $(git rev-list --count main)"
echo "  - Branches :"
for branch in $(git branch --format='%(refname:short)' | grep -v main); do
  count=$(git rev-list --count main..$branch 2>/dev/null || echo "?")
  echo "    - $branch : $count commits"
done
echo "  - Total commits : $(git rev-list --count --all)"
echo ""
