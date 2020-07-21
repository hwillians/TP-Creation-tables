-- a. Listez les articles dans l’ordre alphabétique des désignations
SELECT * FROM Article
WHERE 1
order BY designation;

 -- b. Listez les articles dans l’ordre des prix du plus élevé au moins elevé
SELECT * FROM Article
WHERE 1
order BY prix DESC;

-- c. Listez les articles dont le prix est supérieur à 25€
SELECT * FROM Article
WHERE prix > 25;

-- d. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix AScendant
SELECT * FROM Article AS A
WHERE A.designation LIKE 'Boulon%'
ORDER BY prix;

-- e. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM Article 
WHERE designation LIKE '%sachet%';

-- f. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la cASse !
SELECT * FROM Article 
WHERE lower(designation) LIKE '%sachet%';

-- g. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT A.`designation`, F.nom, A.prix FROM Article AS A 
INNER JOIN Fournisseur AS F on A.`id_fou` = F.id
order BY f.nom, a.prix;

-- h. Listez les articles de la société « Dubois & Fils »
SELECT A.`designation`,f.nom FROM Article AS A 
INNER JOIN Fournisseur AS F on A.`id_fou` = F.id
WHERE f.nom like 'Dubois & Fils'

-- i. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT F.nom,AVG(a.prix) FROM Article AS A 
INNER JOIN Fournisseur AS F on A.`id_fou` = F.id
WHERE f.id =3
GROUP BY f.nom;

-- j. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT F.nom,AVG(a.prix) FROM Article AS A INNER JOIN Fournisseur AS F on A.`id_fou` = F.id
GROUP BY f.nom

-- k. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * FROM bon AS B
WHERE B.date_cmde BETWEEN cASt('2019-03-01' AS DATE) AND cASt('2019-04-05' AS DATE);

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT * FROM bon AS B
INNER JOIN (Article AS A 
INNER JOIN compo AS C on c.id_art=a.id) on c.id_bon = b.id
WHERE A.designation LIKE '%bou%';

-- m. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur ASsocié.
SELECT b.id,b.numero,f.nom FROM bon AS b 
INNER JOIN compo AS c on b.id = c.id_bon 
INNER JOIN article AS a on a.id = c.id_art 
INNER JOIN fournisseur AS f on f.id = a.id_fou
WHERE A.designation LIKE '%bou%';

-- n. Calculez le prix total de chaque bon de commande
SELECT B.numero,sum(A.prix) AS `Prix Total du bon` FROM bon AS B 
INNER JOIN compo AS C on B.id = C.id_bon 
INNER JOIN Article AS A on A.id = C.id_art 
INNER JOIN fournisseur AS f on f.id = a.id_fou
group BY B.numero;

-- o. Comptez le nombre d’articles de chaque bon de commande
SELECT A.designation, COUNT(*) AS compteur FROM bon AS B 
INNER JOIN compo AS C on B.id = c.id_bon
INNER JOIN Article AS A on c.id_art = A.id
GROUP BY A.designation;

-- p. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande
SELECT B.numero, SUM(C.qte) AS total FROM bon AS B 
INNER JOIN compo AS C on C.id_bon = B.id
INNER JOIN Article AS A on C.id_art = A.id
GROUP BY B.numero
HAVING total > 25;

-- q. Calculez le coût total des commandes effectuées sur le mois d’avril
SELECT sum(a.prix*C.qte) FROM bon AS B 
INNER JOIN compo AS C on C.id_bon = B.id
INNER JOIN Article AS A on C.id_art = A.id
WHERE month (B.date_cmde) = 4;

-- ________________________________________________
-- 4) Requêtes plus difficiles
-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : réaliser une auto jointure i.e. de la table avec elle-même)
SELECT DISTINCT A1.designation FROM Article AS A1
INNER JOIN Article AS A2 on A1.designation = A2.designation
WHERE A1.id_fou != A2.id_fou

-- b. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)
SELECT month (b.date_cmde) AS Mois, SUM(A.prix) AS somme FROM bon AS B 
INNER JOIN compo AS C on c.id_art = B.id
INNER JOIN Article AS A on A.id = c.id_art
GROUP BY month(b.date_cmde);