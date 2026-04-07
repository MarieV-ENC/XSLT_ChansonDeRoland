<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  version="2.0">

  <xsl:output method="html" encoding="UTF-8"
              indent="yes" html-version="5"/>

  <!-- VARIABLES -->

  <xsl:variable name="f_index">../html/index.html</xsl:variable>
  <xsl:variable name="f_chateauroux">../html/chateauroux.html</xsl:variable>

  <xsl:variable name="titre_affiche">La Chanson de Roland</xsl:variable>

  <!-- Titre complet extrait du TEI (pour <title> dans <head>) -->
  <xsl:variable name="titre_tei"
    select="normalize-space(//tei:titleStmt/tei:title[1])"/>

  <xsl:variable name="annee"
    select="//tei:publicationStmt/tei:date/@when"/>

  <xsl:variable name="nb_laisses_digby"
    select="count(//tei:div[@xml:id='Digby23']
            /tei:div[@type='laisse'])"/>

  <!-- RÈGLE RACINE -->
    
  <xsl:template match="/">

    <!-- Page index.html -->
    <xsl:result-document href="{$f_index}" method="html">
      <html lang="fr">
        <head>
          <meta charset="UTF-8"/>
          <meta name="viewport"
                content="width=device-width, initial-scale=1.0"/>
          <!-- Titre onglet navigateur -->
          <title><xsl:value-of select="$titre_affiche"/></title>
          <link rel="stylesheet" href="../css/style.css"/>
        </head>
        <body>

          <!--Bandeau image -->
          <div class="bandeau-image">
            <img src="../img/Bayeux.webp"
                 alt=""/>
          </div>

          <!-- En-tête avec titre -->
          <header class="site-header">
            <h1><xsl:value-of select="$titre_affiche"/></h1>
            <p class="sous-titre">
              <xsl:value-of select="normalize-space(
                //tei:titleStmt/tei:title[@type='sub'])"/>
            </p>
          </header>

          <!-- Navigation -->
          <xsl:call-template name="nav">
            <xsl:with-param name="active">index</xsl:with-param>
          </xsl:call-template>

          <main>

            <!-- 1. Sections du front -->
            <xsl:apply-templates select="//tei:front/tei:div"/>

            <!-- 2. Description du manuscrit                      -->
            <section id="manuscrit" class="section-manuscrit">
              <h2>Le manuscrit source</h2>
              <xsl:apply-templates select="//tei:msDesc"/>
            </section>

            <!-- 3. Transcription Digby -->
            <section id="transcription"
                     class="section-transcription">
              <h2>Transcription — MS. Digby 23</h2>

              <!-- Lien vers Châteauroux -->
              <p class="lien-comparaison">
                ↔ Comparer avec
                <a href="{$f_chateauroux}#chateauroux_l211">
                  la version du MS. de Châteauroux (laisse 211)
                </a>
              </p>

              <!-- Conteneur texte + image côte à côte -->
              <div class="transcription-wrapper">

                <!-- Colonne gauche : laisses -->
                <div class="transcription-texte">
                  <xsl:for-each
                    select="//tei:div[@xml:id='Digby23']
                            /tei:div[@type='laisse']">
                    <xsl:apply-templates select="."/>
                  </xsl:for-each>
                </div>

                <!-- Colonne droite : image du manuscrit -->
                <div class="transcription-image">
                  <img
                    src="../img/Grandes_chroniques_Roland.jpg"
                    alt="MS. Digby 23 — fol. 35v"/>
                  <p class="credit-image">
                      Huit moments de la Chanson de Roland (miniature), Turold, XIe siècle.
                  </p>
                </div>

              </div>
            </section>

            <!-- 4. Traduction -->
            <section id="traduction" class="section-traduction">
              <h2>Traduction en français moderne</h2>

              <xsl:apply-templates
                select="//tei:div[@type='translation']
                        [@xml:id='traduction']"/>
                
                <!-- Image centrée -->
                <div class="image-traduction">
                    <img
                        src="../img/chevaliers.jpg"
                        alt=""/>
                </div>
                
            </section>

          </main>

          <xsl:call-template name="footer"/>
        </body>
      </html>
    </xsl:result-document>

    <!-- Page chateauroux.html -->
    
    <xsl:result-document href="{$f_chateauroux}" method="html">
      <html lang="fr">
        <head>
          <meta charset="UTF-8"/>
          <meta name="viewport"
                content="width=device-width, initial-scale=1.0"/>
          <title>MS. de Châteauroux —
            <xsl:value-of select="$titre_affiche"/>
          </title>
          <link rel="stylesheet" href="../css/style.css"/>
        </head>
        <body>

          <!-- Bandeau image -->
          <div class="bandeau-image">
            <img src="../img/Bayeux.webp"
                 alt="Bandeau — La Chanson de Roland"/>
          </div>

          <header class="site-header">
            <h1><xsl:value-of select="$titre_affiche"/></h1>
            <p class="sous-titre">
              MS. de Châteauroux — Laisse 211
            </p>
          </header>

          <xsl:call-template name="nav">
            <xsl:with-param name="active">chateauroux</xsl:with-param>
          </xsl:call-template>

          <main>

            <!-- Présentation -->
            <section id="intro-chx" class="section-intro">
              <h2>Présentation</h2>
              <xsl:apply-templates
                select="//tei:div[@xml:id='chateauroux']/tei:p"/>
              <p class="lien-comparaison">
                ↔ Retourner à la
                <a href="{$f_index}#transcription">
                  transcription du MS. Digby 23
                </a>
              </p>
            </section>

            <!-- Facsimilé -->
            <section id="visionneuse-chx"
                     class="section-visionneuse">
              <h2>Facsimilé</h2>
              <div class="facs-chateauroux">

                <!-- Image du manuscrit de Châteauroux -->
                <div class="facs-image">
                  <img
                    src="../img/chateauroux.png"
                    alt="MS. de Châteauroux — laisse 211"/>
                  <p class="credit-image">
                    MS. de Châteauroux, Médiathèque, 1, f. 51v
                  </p>
                </div>

                <!-- Lien cliquable à droite -->
                <div class="facs-lien">
                  <p>Consulter le manuscrit numérisé en ligne :</p>
                  <a class="btn-externe"
                     href="https://mediatheque.ville-chateauroux.fr/fonds-numerises/fonds-tresors-des-bibliotheques-de-chateauroux?galerieLayout=simple&amp;item=it01/tres-se01-im00010"
                     target="_blank"
                     rel="noopener noreferrer">
                    ↗ Médiathèque de Châteauroux<br/>
                    <span>Fonds numérisé — MS. 1</span>
                  </a>
                </div>

              </div>
            </section>

            <!-- Transcription Châteauroux -->
            <section id="chateauroux_l211"
                     class="section-transcription">
              <h2>Transcription — Laisse 211</h2>
              <xsl:apply-templates
                select="//tei:div[@xml:id='chateauroux']
                        /tei:div[@type='laisse']"/>
            </section>

            <!-- Tableau comparatif -->
            <section id="variantes" class="section-variantes">
              <h2>Variantes entre les deux manuscrits</h2>
              <xsl:call-template name="tableau_variantes"/>
            </section>

          </main>

          <xsl:call-template name="footer"/>
        </body>
      </html>
    </xsl:result-document>

  </xsl:template>

  <!-- Navigation -->
    
  <xsl:template name="nav">
    <xsl:param name="active"/>
    <nav class="navbar">
      <ul>
        <li>
          <a href="{$f_index}">
            <xsl:if test="$active = 'index'">
              <xsl:attribute name="class">active</xsl:attribute>
            </xsl:if>
            Accueil — MS. Digby 23
          </a>
        </li>
        <li>
          <a href="{$f_chateauroux}">
            <xsl:if test="$active = 'chateauroux'">
              <xsl:attribute name="class">active</xsl:attribute>
            </xsl:if>
            MS. de Châteauroux
          </a>
        </li>
      </ul>
    </nav>
  </xsl:template>

  <!-- Front -->
  <xsl:template match="tei:div[@type='introduction']
                       | tei:div[@type='section']">
    <section>
      <xsl:if test="@xml:id">
        <xsl:attribute name="id">
          <xsl:value-of select="@xml:id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">section-front</xsl:attribute>

      <h2><xsl:value-of select="tei:head"/></h2>

      <!-- section légende-->
      <xsl:choose>
        <xsl:when test="@xml:id = 'legende'">
          <div class="legende-wrapper">

            <div class="legende-image">
              <img
                src="../img/Roland.jpg"
                alt="Illustration de Roland sonnant l'alerte"/>
            </div>

            <div class="legende-texte">
              <xsl:apply-templates
                select="tei:p | tei:list | tei:quote"/>
            </div>

          </div>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates
            select="tei:p | tei:list | tei:quote"/>
        </xsl:otherwise>
      </xsl:choose>

    </section>
  </xsl:template>

  <!-- Incipit -->
  <xsl:template match="tei:div[@xml:id='incipit']">
    <section id="incipit" class="section-front section-incipit">
      <h2><xsl:value-of select="tei:head"/></h2>
      <xsl:apply-templates select="tei:p"/>
      <xsl:apply-templates select="tei:quote"/>
    </section>
  </xsl:template>

  <!-- Traduction de l'incipit -->
  <xsl:template match="tei:div[@type='translation']
                       [@xml:id='trad_incipit']">
    <div class="traduction-incipit">
      <h3><xsl:value-of select="tei:head"/></h3>
      <xsl:apply-templates select="tei:quote"/>
    </div>
  </xsl:template>

  <!-- Paragraphes -->
  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- Listes -->
  <xsl:template match="tei:list[@type='unordered']">
    <ul class="liste-manuscrits">
      <xsl:for-each select="tei:item">
        <li><xsl:apply-templates/></li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template match="tei:list[@type='ordered']">
    <ol>
      <xsl:for-each select="tei:item">
        <li><xsl:apply-templates/></li>
      </xsl:for-each>
    </ol>
  </xsl:template>

  <!-- Description manuscrit-->
  <xsl:template match="tei:msDesc">
    <div class="ms-desc">

      <!-- Identification -->
      <div class="ms-identifier ms-bloc">
        <h3>Identification</h3>
        <dl>
          <dt>Institution</dt>
          <dd>
            <xsl:value-of
              select="tei:msIdentifier/tei:institution"/>
          </dd>
          <dt>Cote</dt>
          <dd>
            <xsl:value-of select="concat(
              tei:msIdentifier/tei:idno[@type='shelfmark'],
              ' (SC : ',
              tei:msIdentifier/tei:idno[@type='SC'], ')')"/>
          </dd>
          <dt>Lieu</dt>
          <dd>
            <xsl:value-of select="concat(
              tei:msIdentifier/tei:settlement, ', ',
              tei:msIdentifier/tei:country)"/>
          </dd>
        </dl>
      </div>

      <!-- Contenu -->
      <div class="ms-summary ms-bloc">
        <h3>Contenu</h3>
        <p>
          <xsl:value-of
            select="normalize-space(tei:msContents/tei:summary)"/>
        </p>
      </div>

      <!-- Description physique -->
      <div class="ms-physdesc ms-bloc">
        <h3>Description physique</h3>
        <dl>
          <dt>Support</dt>
          <dd>
            <xsl:value-of select="normalize-space(
              tei:msPart/tei:physDesc/tei:objectDesc
              /tei:supportDesc/tei:support)"/>
          </dd>
          <dt>Dimensions</dt>
          <dd>
            <xsl:value-of select="concat(
              tei:msPart/tei:physDesc/tei:objectDesc
              /tei:supportDesc/tei:extent
              /tei:dimensions/tei:height, ' × ',
              tei:msPart/tei:physDesc/tei:objectDesc
              /tei:supportDesc/tei:extent
              /tei:dimensions/tei:width, ' mm')"/>
          </dd>
          <dt>Mise en page</dt>
          <dd>
            <xsl:value-of select="normalize-space(
              tei:msPart/tei:physDesc/tei:objectDesc
              /tei:layoutDesc/tei:layout)"/>
          </dd>
          <dt>Décoration</dt>
          <dd>
            <xsl:value-of select="normalize-space(
              tei:msPart/tei:physDesc/tei:decoDesc
              /tei:decoNote)"/>
          </dd>
        </dl>
      </div>

      <!-- Images du manuscrit Digby 23-->
      <div class="ms-images">
        <figure class="ms-figure">
          <img
            src="../img/35v.png"
            alt="MS. Digby 23 — vue 35v"/>
          <figcaption>MS. Digby 23, fol. 35v</figcaption>
        </figure>
        <figure class="ms-figure">
          <img
            src="../img/36r.png"
            alt="MS. Digby 23 — vue 36r"/>
          <figcaption>MS. Digby 23, fol. 36r</figcaption>
        </figure>
      </div>

    </div>
  </xsl:template>

  <!-- Laisses -->
  <xsl:template match="tei:div[@type='laisse']">
    <div class="laisse" id="laisse_{@n}">
      <h3>Laisse <xsl:value-of select="number(@n)"/></h3>
      <xsl:apply-templates select="tei:lg | tei:p"/>
    </div>
  </xsl:template>

  <!-- Groupes de vers -->
  <xsl:template match="tei:lg">
    <div class="groupe-vers">
      <xsl:apply-templates select="tei:l | tei:seg"/>
    </div>
  </xsl:template>

  <!-- vers-->
  <xsl:template match="tei:l">
    <p class="vers">
      <span class="num-vers">
        <xsl:value-of select="@n"/>
      </span>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- Sauts de page-->
  <xsl:template match="tei:pb">
    <div class="pb" id="{@xml:id}">
      <span class="pb-label">[f. <xsl:value-of select="@n"/>]</span>
      <xsl:if test="@facs">
        <a href="{@facs}" target="_blank"
           class="lien-facs" rel="noopener noreferrer">
          ↗ Voir le folio
        </a>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- Ignorer les lb -->
  <xsl:template match="tei:lb"/>

  <!-- Citations -->
  <xsl:template match="tei:quote">
    <blockquote class="citation-ms">
      <xsl:apply-templates select="tei:lg | tei:l"/>
    </blockquote>
  </xsl:template>

  <!-- Typographie du texte -->
  <xsl:template match="tei:hi[@rend='bold']">
    <strong><xsl:apply-templates/></strong>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='italic']">
    <em><xsl:apply-templates/></em>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='bold italic']">
    <strong><em><xsl:apply-templates/></em></strong>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='initial-red']">
    <span class="initiale-rouge"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:hi[@rend='small-caps']">
    <span class="small-caps"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- titres -->
  <xsl:template match="tei:title">
    <cite><xsl:apply-templates/></cite>
  </xsl:template>

  <!-- corps de traduction -->
  <xsl:template match="tei:div[@type='translation']
                       [@xml:id='traduction']">
    <div class="traduction">
      <xsl:apply-templates select="tei:p"/>
      <xsl:for-each select="tei:div[@type='laisse']">
        <div class="laisse-trad" id="{@xml:id}">
          <xsl:if test="tei:head">
            <h3><xsl:value-of select="tei:head"/></h3>
          </xsl:if>
          <xsl:apply-templates select="tei:p"/>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

    <!-- tableau comparatif des versions -->
    
    <xsl:template name="tableau_variantes">
        
        <!-- Variable définie au niveau du template               -->
        <!-- hors de tout xsl:for-each, avec chemin explicite     -->
        <xsl:variable name="vers_chx_tous"
            select="//tei:div[@type='text'][@xml:id='chateauroux']
            //tei:div[@type='laisse'][@n='211']
            /tei:lg/tei:l"/>
        
        <table class="tableau-variantes">
            <thead>
                <tr>
                    <th>V.</th>
                    <th>MS. Digby 23 — laisses 146–147</th>
                    <th>MS. Châteauroux — laisse 211</th>
                </tr>
            </thead>
            <tbody>
                
                <xsl:for-each
                    select="//tei:div[@xml:id='Digby23']
                    //tei:div[@type='laisse']/tei:lg/tei:l">
                    
                    <xsl:variable name="pos" select="position()"/>
                    <xsl:variable name="nv"  select="@n"/>
                    
                    <xsl:variable name="texte_digby"
                        select="normalize-space(.)"/>
                    
                    <!-- Sélection du vers Châteauroux par position -->
                    <xsl:variable name="vers_chx"
                        select="$vers_chx_tous[$pos]"/>
                    
                    <tr>
                        <xsl:if test="$pos = 1">
                            <xsl:attribute name="class">premier-vers</xsl:attribute>
                        </xsl:if>
                        
                        <!-- Numéro du vers Digby -->
                        <td class="num-col">
                            <xsl:value-of select="$nv"/>
                        </td>
                        
                        <!-- Texte Digby -->
                        <td lang="xno">
                            <xsl:value-of select="$texte_digby"/>
                        </td>
                        
                        <!-- Texte Châteauroux -->
                        <td lang="xno">
                            <xsl:choose>
                                <xsl:when test="$vers_chx">
                                    <xsl:variable name="texte_chx"
                                        select="normalize-space($vers_chx)"/>
                                    <xsl:choose>
                                        <!-- Variante : texte différent → italique rouge -->
                                        <xsl:when test="$texte_digby != $texte_chx">
                                            <span class="variante">
                                                <xsl:value-of select="$texte_chx"/>
                                            </span>
                                        </xsl:when>
                                        <!-- Texte identique -->
                                        <xsl:otherwise>
                                            <xsl:value-of select="$texte_chx"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <!-- Pas de vers correspondant -->
                                <xsl:otherwise>
                                    <em class="lacune">—</em>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        
                    </tr>
                </xsl:for-each>
                
            </tbody>
        </table>
    </xsl:template>
    
  <!-- Footer -->
  <xsl:template name="footer">
    <footer class="site-footer">
      <p>
        <xsl:if test="string-length(string($annee)) > 0">
          © <xsl:value-of select="$annee"/> —
        </xsl:if>
        <xsl:value-of select="normalize-space(
          //tei:publicationStmt/tei:publisher)"/>
      </p>
    </footer>
  </xsl:template>

</xsl:stylesheet>