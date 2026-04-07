# ⚔️ La Chanson de Roland — édition numérique comparative 🛡️

Ce projet a été réalisé dans le cadre du cours **Techniques et chaîne de publication électronique** du master 2 Technologies numériques appliquées à l'histoire (TNAH) de École nationale des chartes — PSL, 2025-2026.

Ce projet a été rendu pour évaluation le 08 avril 2026.

---

## 🗡️ Présentation du projet

Ce projet propose une édition numérique comparative de la **Chanson de Roland** à partir de deux manuscrits médiévaux :

- Le **MS. Digby 23** (Bodleian Library, Oxford), copie la plus ancienne de l'œuvre, rédigée en anglo-normand dans le deuxième quart du XIIe siècle. Les **laisses 146 et 147** sont ici transcrites et éditées.
- Le **MS. de Châteauroux** (Médiathèque de Châteauroux), témoin du XIIIe siècle, dont la **laisse 211** correspond au même passage avec d'importantes variantes.

Notre édition numérique propose :

- une introduction générale à l'œuvre (origine historique, légende, tradition manuscrite, etc.) ;
- la transcription des laisses 146 et 147 du MS. Digby 23 ;
- la transcription de la laisse 211 du MS. de Châteauroux ;
- une traduction en français moderne (d'après Pierre Jonin, Folio Classiques, 1979) ;
- un tableau comparatif des variantes entre les deux manuscrits.

---

## ⚔️ Structure du projet
```
projet-roland/
│
├── xml/
│   └── LaChansonDeRoland.xml     # Document source encodé en XML-TEI
│
├── xsl/
│   └── LaChansonDeRoland.xsl     # Feuille de transformation XSLT 2.0
│
├── css/
│   └── style.css                 # Feuille de style CSS
│
├── html/                         # Fichiers HTML générés par la transformation
│   ├── index.html                # Page d'accueil — MS. Digby 23
│   └── chateauroux.html          # Page — MS. de Châteauroux
│
└── img/                          # Images utilisées dans les pages HTML
    ├── bandeau.jpg
    ├── legende.jpg
    ├── ms_digby_35v.jpg
    ├── ms_digby_36r.jpg
    ├── ms_chateauroux.jpg
    └── traduction.jpg
```

---
## ⚙️ Transformation XSLT

La feuille de style `LaChansonDeRoland.xsl` est écrite en **XSLT 2.0** et requiert le processeur **Saxon** (HE, PE ou EE).

### Exécution dans oXygen XML Editor

1. Ouvrir `LaChansonDeRoland.xml` et `LaChansonDeRoland.xsl`dans oXygen
2. Aller dans l'onglet Perspective XSLT Debugger
4. Paramêtrer dans le menu:
   - **XML** : `LaChansonDeRoland.xml`
   - **XSL** : `LaChansonDeRoland.xml`
   - **Processeur** : Saxon-HE (ou PE/EE)
5. Cliquer sur la flèche bleue pour exécuter la transformation
6. Les fichiers `index.html` et `chateauroux.html` sont générés dans le dossier `html/`

---

## 📚 Sources et références

Ce projet se base sur un dossier documentaire réalisé par **Lucence Ing**, doctorante de l'ENC sur la thématique *L’obsolescence lexicale en français médiéval. Philologie et linguistique computationnelles sur le Lancelot en prose* (thèse soutenue en 2023)

**Manuscrits**

- MS. Digby 23, Bodleian Library, Oxford —
  [Digital Bodleian](https://digital.bodleian.ox.ac.uk/objects/79097275-ef1d-4107-85d3-e8402120f365/)
- MS. de Châteauroux, Médiathèque de Châteauroux, 1 —
  [Fonds numérisé](https://mediatheque.ville-chateauroux.fr/fonds-numerises/)

**Sources bibliographiques**

- BEDIER, Joseph, *Les légendes épiques. Recherches sur la formation des chansons de geste. Troisième édition*, Paris, Champion, 1926-1929, 4 t. Disponible en ligne sur Gallica ou Internet Archive.
- JANICKE, Stefan et David Joseph Wrisley, "Visualizing Mouvance : toward a Visual Analysis of Variant Medieval Text Traditions", *Digital Scholarship in the Humanities*, 32-supp. 2, 2017.
- JONIN, Pierre, *La Chanson de Roland*, paris, Folio Classiques, 1979, p. 213-215.
- KIBLER, William W., "The Roland after Oxford : The French Tradition", *Olifant*, 6-3/4, *Proceedings of the Pennsylvania State Conference*, 1979, p. 275-292. 
- LOVE, Nathan, "AOI in the *Chanson de Roland* : a Divergent Hypothesis", *Olifant*, 10-4, 1984, p.182-187.
- PALUMBO, Giovanni, "laisses assonancées dans les manuscrits rimés C et V7. la sous-famille y et la diffusion italienne de la *Chanson de Roland*", dans *Romania*, 2011, 515-516, p. 257-270.

---

## ✍️ Responsables

| Rôle | Nom |
|---|---|
| Encodage XML-TEI | Marie Vielmas |
| Enseignant évaluateur | Jean Damien Genero |

---

*École nationale des chartes — Master 2 TNAH — 2025-2026*
