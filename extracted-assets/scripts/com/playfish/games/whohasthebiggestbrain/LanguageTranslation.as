package com.playfish.games.whohasthebiggestbrain
{
   public class LanguageTranslation
   {
      
      private static const NUMBERS_TEXT:Object = {
         "ENGLISH":["ZERO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE","TEN"],
         "ESPAÑOL":["CERO","UNO","DOS","TRES","CUATRO","CINCO","SEIS","SIETE","OCHO","NUEVE","DIEZ"],
         "FRANÇAIS":["ZÉRO","UN","DEUX","TROIS","QUATRE","CINQ","SIX","SEPT","HUIT","NEUF","DIX"],
         "ITALIANO":["ZERO","UNO","DUE","TRE","QUATTRO","CINQUE","SEI","SETTE","OTTO","NOVE","DIECI"],
         "PORTUGUÊS":["ZERO","UM","DOIS","TRÊS","QUATRO","CINCO","SEIS","SETE","OITO","NOVE","DEZ"],
         "DEUTSCH":["NULL","EINS","ZWEI","DREI","VIER","FÜNF","SECHS","SIEBEN","ACHT","NEUN","ZEHN"],
         "NEDERLANDS":["NUL","EEN","TWEE","DRIE","VIER","VIJF","ZES","ZEVEN","ACHT","NEGEN","TIEN"],
         "SVENSKA":["NOLL","ETT","TVÅ","TRE","FYRA","FEM","SEX","SJU","ÅTTA","NIO","TIO"],
         "NORSK":["NULL","EN","TO","TRE","FIRE","FEM","SEKS","SYV","ÅTTE","NI","TI"],
         "SUOMI":["NOLLA","YKSI","KAKSI","KOLME","NELJÄ","VIISI","KUUSI","SEITSEMÄN","KAHDEKSAN","YHDEKSÄN","KYMMENEN"],
         "POLSKI":["ZERO","JEDEN","DWA","TRZY","CZTERY","PIĘĆ","SZEŚĆ","SIEDEM","OSIEM","DZIEWIĘĆ","DZIESIĘĆ"],
         "ΕΛΛΗΝΙΚΑ":["ΜΗΔΕΝ","ΕΝΑ","ΔΥΟ","ΤΡΙΑ","ΤΕΣΣΕΡΑ","ΠΕΝΤΕ","ΕΞΙ","ΕΠΤΑ","ΟΚΤΩ","ΕΝΝΕΑ","ΔΕΚΑ"]
      };
      
      private static const INVITE_TEXT_1:Object = {
         "ENGLISH":"Who Has The Biggest Brain? Is a lot more fun when you enjoy it with your friends! Choose which friends to share the game with now.",
         "ESPAÑOL":"¿Quién Tiene El Cerebro Más Grande? Es mucho más divertido cuando lo disfrutas con tus amigos. ¡Elige ahora con qué amigos compartir el juego!",
         "FRANÇAIS":"Qui A Le Plus Gros Cerveau ? C’est beaucoup plus amusant quand vous en profitez avec vos amis ! Choisissez avec quels amis partager le jeu maintenant.",
         "ITALIANO":"Chi Ha Il Cervello Più Grande? È molto più divertente quando lo giochi con i tuoi amici! Scegli subito con quali amici condividere il gioco.",
         "PORTUGUÊS":"Quem Tem O Maior Cérebro? É muito mais divertido quando você aproveita com seus amigos! Escolha agora com quais amigos compartilhar o jogo.",
         "DEUTSCH":"Wer Hat Das Größte Gehirn? Es macht viel mehr Spaß, wenn du es mit deinen Freunden spielst! Wähle jetzt, mit welchen Freunden du das Spiel teilen möchtest.",
         "NEDERLANDS":"Wie Heeft Het Grootste Brein? Het is veel leuker wanneer je het met je vrienden speelt! Kies nu met welke vrienden je het spel wilt delen.",
         "SVENSKA":"Vem Har Den Största Hjärnan? Det är mycket roligare när du spelar det med dina vänner! Välj nu vilka vänner du vill dela spelet med.",
         "NORSK":"Hvem Har Den Største Hjernen? Det er mye morsommere når du spiller det med vennene dine! Velg nå hvilke venner du vil dele spillet med.",
         "SUOMI":"Kenellä On Suurin Aivot? Se on paljon hauskempaa, kun nautit siitä ystäviesi kanssa! Valitse nyt, minkä ystävien kanssa haluat jakaa pelin.",
         "POLSKI":"Kto Ma Największy Mózg? To jest o wiele zabawniejsze, gdy grasz w to ze swoimi przyjaciółmi! Wybierz teraz, z którymi przyjaciółmi chcesz podzielić się grą.",
         "ΕΛΛΗΝΙΚΑ":"Ποιος Έχει Τον Μεγαλύτερο Εγκέφαλο; Είναι πολύ πιο διασκεδαστικό όταν το απολαμβάνεις με τους φίλους σου! Διάλεξε τώρα με ποιους φίλους θα μοιραστείς το παιχνίδι."
      };
      
      private static const WELCOME_TEXT_1:Object = {
         "ENGLISH":"Welcome! Got a big BRAIN? Play Who Has The Biggest Brain? to find out!",
         "ESPAÑOL":"¡Bienvenido! ¿Tienes un gran CEREBRO? Juega Who Has The Biggest Brain? para descubrirlo!",
         "FRANÇAIS":"Bienvenue ! Un grand CERVEAU ? Jouez à Who Has The Biggest Brain? pour le découvrir !",
         "ITALIANO":"Benvenuto! Hai un grande CERVELLO? Gioca a Who Has The Biggest Brain? per scoprirlo!",
         "PORTUGUÊS":"Bem-vindo! Tem um grande CÉREBRO? Jogue Who Has The Biggest Brain? para descobrir!",
         "DEUTSCH":"Willkommen! Hast du ein großes GEHIRN? Spiele Who Has The Biggest Brain? um es herauszufinden!",
         "NEDERLANDS":"Welkom! Heb jij een groot BREIN? Speel Who Has The Biggest Brain? om erachter te komen!",
         "SVENSKA":"Välkommen! Har du en stor HJÄRNA? Spela Who Has The Biggest Brain? för att ta reda på det!",
         "NORSK":"Velkommen! Har du en stor HJERNE? Spill Who Has The Biggest Brain? for å finne det ut!",
         "SUOMI":"Tervetuloa! Onko sinulla suuret AIVOT? Pelaa Who Has The Biggest Brain? ja ota selvää!",
         "POLSKI":"Witamy! Masz duży MÓZG? Zagraj w Who Has The Biggest Brain? i przekonaj się!",
         "ΕΛΛΗΝΙΚΑ":"Καλώς ήρθες! Έχεις μεγάλο ΕΓΚΕΦΑΛΟ; Παίξε Who Has The Biggest Brain? για να το ανακαλύψεις!"
      };
      
      private static const WELCOME_TEXT_2:Object = {
         "ENGLISH":["Welcome! Got a big BRAIN? Play Who Has The Biggest Brain? to find out!","Welcome back! Another game of Who Has The Biggest Brain? perhaps?","And now for our next contestant... Let\'s play Who Has The Biggest Brain?"],
         "ESPAÑOL":["¡Bienvenido! ¿Tienes un gran CEREBRO? Juega Who Has The Biggest Brain? para descubrirlo!","¡Bienvenido de nuevo! ¿Otra partida de Who Has The Biggest Brain?","Y ahora nuestro próximo concursante... ¡Juguemos Who Has The Biggest Brain?"],
         "FRANÇAIS":["Bienvenue ! Un grand CERVEAU ? Jouez à Who Has The Biggest Brain? pour le découvrir !","Bon retour ! Une autre partie de Who Has The Biggest Brain ?","Et maintenant notre prochain candidat... Jouons à Who Has The Biggest Brain?"],
         "ITALIANO":["Benvenuto! Hai un grande CERVELLO? Gioca a Who Has The Biggest Brain? per scoprirlo!","Bentornato! Un\'altra partita di Who Has The Biggest Brain?","Ed ora il nostro prossimo concorrente... Giochiamo a Who Has The Biggest Brain?"],
         "PORTUGUÊS":["Bem-vindo! Tem um grande CÉREBRO? Jogue Who Has The Biggest Brain? para descobrir!","Bem-vindo de volta! Mais uma partida de Who Has The Biggest Brain?","E agora o nosso próximo concorrente... Vamos jogar Who Has The Biggest Brain?"],
         "DEUTSCH":["Willkommen! Hast du ein großes GEHIRN? Spiele Who Has The Biggest Brain? um es herauszufinden!","Willkommen zurück! Noch ein Spiel Who Has The Biggest Brain?","Und nun unser nächster Kandidat... Spielen wir Who Has The Biggest Brain?"],
         "NEDERLANDS":["Welkom! Heb jij een groot BREIN? Speel Who Has The Biggest Brain? om erachter te komen!","Welkom terug! Nog een spelletje Who Has The Biggest Brain?","En nu onze volgende deelnemer... Laten we Who Has The Biggest Brain? spelen!"],
         "SVENSKA":["Välkommen! Har du en stor HJÄRNA? Spela Who Has The Biggest Brain? för att ta reda på det!","Välkommen tillbaka! Ännu ett spel av Who Has The Biggest Brain?","Och nu vår nästa tävlande... Låt oss spela Who Has The Biggest Brain?"],
         "NORSK":["Velkommen! Har du en stor HJERNE? Spill Who Has The Biggest Brain? for å finne det ut!","Velkommen tilbake! En ny runde Who Has The Biggest Brain?","Og nå vår neste deltaker... La oss spille Who Has The Biggest Brain?"],
         "SUOMI":["Tervetuloa! Onko sinulla suuret AIVOT? Pelaa Who Has The Biggest Brain? ja ota selvää!","Tervetuloa takaisin! Vielä yksi peli Who Has The Biggest Brain?","Ja nyt seuraava kilpailija... Pelataan Who Has The Biggest Brain?"],
         "POLSKI":["Witamy! Masz duży MÓZG? Zagraj w Who Has The Biggest Brain? i przekonaj się!","Witaj ponownie! Kolejna gra w Who Has The Biggest Brain?","A teraz nasz kolejny zawodnik... Zagrajmy w Who Has The Biggest Brain?"],
         "ΕΛΛΗΝΙΚΑ":["Καλώς ήρθες! Έχεις μεγάλο ΕΓΚΕΦΑΛΟ; Παίξε Who Has The Biggest Brain? για να το ανακαλύψεις!","Καλώς επέστρεψες! Άλλο ένα παιχνίδι Who Has The Biggest Brain?","Και τώρα ο επόμενος διαγωνιζόμενος... Ας παίξουμε Who Has The Biggest Brain?"]
      };
      
      private static const WELCOME_TEXT_3:Object = {
         "ENGLISH":["Play Who Has The Biggest Brain? on Facebook to see FRIENDS playing!","To see FRIENDS\' scores, play Who Has The Biggest Brain? on Facebook!","Did you know you can see FRIENDS\' scores by playing Who Has The Biggest Brain? on Facebook?"],
         "ESPAÑOL":["¡Juega Who Has The Biggest Brain? en Facebook para ver a tus AMIGOS jugando!","Para ver las puntuaciones de tus AMIGOS, juega Who Has The Biggest Brain? en Facebook!","¿Sabías que puedes ver las puntuaciones de tus AMIGOS jugando Who Has The Biggest Brain? en Facebook?"],
         "FRANÇAIS":["Jouez à Who Has The Biggest Brain? sur Facebook pour voir vos AMIS jouer !","Pour voir les scores de vos AMIS, jouez à Who Has The Biggest Brain? sur Facebook !","Saviez-vous que vous pouvez voir les scores de vos AMIS en jouant à Who Has The Biggest Brain? sur Facebook ?"],
         "ITALIANO":["Gioca a Who Has The Biggest Brain? su Facebook per vedere i tuoi AMICI giocare!","Per vedere i punteggi dei tuoi AMICI, gioca a Who Has The Biggest Brain? su Facebook!","Lo sapevi che puoi vedere i punteggi dei tuoi AMICI giocando a Who Has The Biggest Brain? su Facebook?"],
         "PORTUGUÊS":["Jogue Who Has The Biggest Brain? no Facebook para ver seus AMIGOS jogando!","Para ver as pontuações dos seus AMIGOS, jogue Who Has The Biggest Brain? no Facebook!","Você sabia que pode ver as pontuações dos seus AMIGOS jogando Who Has The Biggest Brain? no Facebook?"],
         "DEUTSCH":["Spiele Who Has The Biggest Brain? auf Facebook, um deine FREUNDE spielen zu sehen!","Um die Ergebnisse deiner FREUNDE zu sehen, spiele Who Has The Biggest Brain? auf Facebook!","Wusstest du, dass du die Ergebnisse deiner FREUNDE sehen kannst, indem du Who Has The Biggest Brain? auf Facebook spielst?"],
         "NEDERLANDS":["Speel Who Has The Biggest Brain? op Facebook om je VRIENDEN te zien spelen!","Om de scores van je VRIENDEN te zien, speel Who Has The Biggest Brain? op Facebook!","Wist je dat je de scores van je VRIENDEN kunt zien door Who Has The Biggest Brain? op Facebook te spelen?"],
         "SVENSKA":["Spela Who Has The Biggest Brain? på Facebook för att se dina VÄNNER spela!","För att se dina VÄNNERS poäng, spela Who Has The Biggest Brain? på Facebook!","Visste du att du kan se dina VÄNNERS poäng genom att spela Who Has The Biggest Brain? på Facebook?"],
         "NORSK":["Spill Who Has The Biggest Brain? på Facebook for å se VENNER spille!","For å se VENNERS poeng, spill Who Has The Biggest Brain? på Facebook!","Visste du at du kan se VENNERS poeng ved å spille Who Has The Biggest Brain? på Facebook?"],
         "SUOMI":["Pelaa Who Has The Biggest Brain? Facebookissa nähdäksesi YSTÄVÄSI pelaamassa!","Nähdäksesi YSTÄVIESI pisteet, pelaa Who Has The Biggest Brain? Facebookissa!","Tiesitkö, että voit nähdä YSTÄVIESI pisteet pelaamalla Who Has The Biggest Brain? Facebookissa?"],
         "POLSKI":["Zagraj w Who Has The Biggest Brain? na Facebooku, aby zobaczyć grających PRZYJACIÓŁ!","Aby zobaczyć wyniki PRZYJACIÓŁ, zagraj w Who Has The Biggest Brain? na Facebooku!","Czy wiesz, że możesz zobaczyć wyniki PRZYJACIÓŁ, grając w Who Has The Biggest Brain? na Facebooku?"],
         "ΕΛΛΗΝΙΚΑ":["Παίξε Who Has The Biggest Brain? στο Facebook για να δεις τους ΦΙΛΟΥΣ σου να παίζουν!","Για να δεις τα σκορ των ΦΙΛΩΝ σου, παίξε Who Has The Biggest Brain? στο Facebook!","Ήξερες ότι μπορείς να δεις τα σκορ των ΦΙΛΩΝ σου παίζοντας Who Has The Biggest Brain? στο Facebook?"]
      };
      
      private static const INVITE_TEXT_2:Object = {
         "ENGLISH":["Hey, why not invite friends online to join the show or have another go?","Hey - one more game perhaps? Or invite some friends on Facebook?","Well done! Play again? Or invite a few more friends to compare brains with?"],
         "ESPAÑOL":["Oye, ¿por qué no invitas a tus amigos en línea a unirse al show o jugar otra vez?","Oye, ¿otra partida tal vez? ¿O invitas a algunos amigos en Facebook?","¡Bien hecho! ¿Jugar de nuevo? ¿O invitas a unos cuantos amigos más para comparar cerebros?"],
         "FRANÇAIS":["Hé, pourquoi ne pas inviter des amis en ligne à rejoindre le spectacle ou rejouer ?","Hé – une autre partie peut-être ? Ou inviter des amis sur Facebook ?","Bien joué ! Rejouer ? Ou inviter quelques amis de plus pour comparer les cerveaux ?"],
         "ITALIANO":["Ehi, perché non inviti degli amici online a unirsi allo show o a fare un\'altra partita?","Ehi – un\'altra partita forse? Oppure invita alcuni amici su Facebook?","Ben fatto! Giochi ancora? Oppure invita qualche amico in più per confrontare i cervelli?"],
         "PORTUGUÊS":["Ei, que tal convidar amigos online para participar do show ou jogar novamente?","Ei – mais uma partida talvez? Ou convide alguns amigos no Facebook?","Muito bem! Jogar de novo? Ou convide mais alguns amigos para comparar cérebros?"],
         "DEUTSCH":["Hey, warum nicht Freunde online einladen, um bei der Show mitzumachen oder noch einmal zu spielen?","Hey – noch ein Spiel vielleicht? Oder lade ein paar Freunde auf Facebook ein?","Gut gemacht! Nochmals spielen? Oder ein paar Freunde mehr einladen, um Gehirne zu vergleichen?"],
         "NEDERLANDS":["Hé, waarom geen vrienden online uitnodigen om mee te doen of nog een keer te spelen?","Hé – nog een spelletje misschien? Of nodig wat vrienden uit op Facebook?","Goed gedaan! Nog een keer spelen? Of nodig nog een paar vrienden uit om breinen te vergelijken?"],
         "SVENSKA":["Hej, varför inte bjuda in vänner online att gå med i showen eller spela en gång till?","Hej – ett spel till kanske? Eller bjud in några vänner på Facebook?","Bra jobbat! Spela igen? Eller bjud in några fler vänner för att jämföra hjärnor?"],
         "NORSK":["Hei, hvorfor ikke invitere venner på nettet til å bli med i showet eller spille en gang til?","Hei – ett spill til kanskje? Eller inviter noen venner på Facebook?","Bra gjort! Spille igjen? Eller inviter noen flere venner for å sammenligne hjerner?"],
         "SUOMI":["Hei, mikset et kutsu ystäviä verkossa liittymään ohjelmaan tai pelaamaan uudestaan?","Hei – vielä yksi peli ehkä? Tai kutsu joitakin ystäviä Facebookissa?","Hienoa! Pelaatko uudestaan? Vai kutsutko vielä muutaman ystävän vertailemaan aivoja?"],
         "POLSKI":["Hej, może zaprosisz znajomych online, aby dołączyli do programu lub zagrać jeszcze raz?","Hej – może jeszcze jedna gra? Albo zaproś kilku znajomych na Facebooku?","Dobra robota! Zagrać ponownie? A może zaprosić jeszcze kilku znajomych, aby porównać mózgi?"],
         "ΕΛΛΗΝΙΚΑ":["Γεια, γιατί δεν προσκαλείς φίλους online να μπουν στο σόου ή να παίξουν άλλη μία φορά;","Γεια – άλλο ένα παιχνίδι ίσως; Ή προσκάλεσε μερικούς φίλους στο Facebook;","Μπράβο! Παίζουμε ξανά; Ή προσκάλεσε μερικούς ακόμη φίλους για να συγκρίνετε εγκέφαλους;"]
      };
      
      private static const SCORE_TEXT_1:Object = {
         "ENGLISH":"Altogether not bad at all for a beginner! Let\'s see who you BEAT to get there!",
         "ESPAÑOL":"¡En conjunto no está nada mal para un principiante! ¡Veamos a quién VENCISTE para llegar hasta aquí!",
         "FRANÇAIS":"Dans l\'ensemble, pas mal du tout pour un débutant ! Voyons qui tu as BATTU pour en arriver là !",
         "ITALIANO":"Nel complesso niente male per un principiante! Vediamo chi hai BATTUTO per arrivare fin qui!",
         "PORTUGUÊS":"No geral, nada mal para um iniciante! Vamos ver quem você DERROTOU para chegar até aqui!",
         "DEUTSCH":"Alles in allem gar nicht schlecht für einen Anfänger! Mal sehen, wen du BESIEGT hast, um hierher zu kommen!",
         "NEDERLANDS":"Al met al helemaal niet slecht voor een beginner! Laten we eens kijken wie je VERSLAGEN hebt om hier te komen!",
         "SVENSKA":"Sammantaget inte alls dåligt för en nybörjare! Låt oss se vem du BESEGRADE för att komma hit!",
         "NORSK":"Alt i alt slett ikke verst for en nybegynner! La oss se hvem du SLO for å komme hit!",
         "SUOMI":"Kaiken kaikkiaan ei ollenkaan huonoa aloittelijalle! Katsotaan ketä VOITIT päästäksesi tähän!",
         "POLSKI":"Jak na początkującego, wcale nieźle! Zobaczmy, kogo POKONAŁEŚ, aby dojść tutaj!",
         "ΕΛΛΗΝΙΚΑ":"Συνολικά, καθόλου κακό για έναν αρχάριο! Ας δούμε ποιον ΝΙΚΗΣΕΣ για να φτάσεις εδώ!"
      };
      
      private static const SCORE_TEXT_2:Object = {
         "ENGLISH":"Hmm... something seems to be wrong with your score and I can\'t accept it as a valid result. Please try again.",
         "ESPAÑOL":"Hmm... parece que hay un problema con tu puntuación y no puedo aceptarla como un resultado válido. Por favor, inténtalo de nuevo.",
         "FRANÇAIS":"Hmm... il semble y avoir un problème avec ton score et je ne peux pas l\'accepter comme résultat valide. Merci de réessayer.",
         "ITALIANO":"Hmm... sembra che ci sia un problema con il tuo punteggio e non posso accettarlo come risultato valido. Per favore, riprova.",
         "PORTUGUÊS":"Hmm... parece haver um problema com a sua pontuação e não posso aceitá-la como um resultado válido. Por favor, tente novamente.",
         "DEUTSCH":"Hmm... irgendetwas scheint mit deinem Ergebnis nicht zu stimmen und ich kann es nicht als gültig akzeptieren. Bitte versuche es erneut.",
         "NEDERLANDS":"Hmm... er lijkt iets mis te zijn met je score en ik kan het niet accepteren als geldig resultaat. Probeer het alstublieft opnieuw.",
         "SVENSKA":"Hmm... något verkar vara fel med ditt resultat och jag kan inte acceptera det som giltigt. Försök igen.",
         "NORSK":"Hmm... noe ser ut til å være galt med poengsummen din, og jeg kan ikke godta den som et gyldig resultat. Vennligst prøv igjen.",
         "SUOMI":"Hmm... jotain näyttää olevan vialla pisteidesi kanssa, enkä voi hyväksyä niitä kelvollisina. Yritä uudelleen.",
         "POLSKI":"Hmm... coś wydaje się być nie tak z twoim wynikiem i nie mogę go zaakceptować jako prawidłowego. Spróbuj ponownie.",
         "ΕΛΛΗΝΙΚΑ":"Χμμ... φαίνεται πως υπάρχει κάποιο πρόβλημα με το σκορ σου και δεν μπορώ να το δεχτώ ως έγκυρο αποτέλεσμα. Παρακαλώ δοκίμασε ξανά."
      };
      
      private static const SCORE_TEXT_3:Object = {
         "ENGLISH":"EXCELLENT! You have officially the BIGGEST BRAIN among your FRIENDS! Let\'s see who you beat to get there!",
         "ESPAÑOL":"¡EXCELENTE! ¡Oficialmente tienes el CEREBRO MÁS GRANDE entre tus AMIGOS! ¡Veamos a quién superaste para llegar allí!",
         "FRANÇAIS":"EXCELLENT ! Tu as officiellement le PLUS GROS CERVEAU parmi tes AMIS ! Voyons qui tu as battu pour en arriver là !",
         "ITALIANO":"ECCELLENTE! Hai ufficialmente il CERVELLO PIÙ GRANDE tra i tuoi AMICI! Vediamo chi hai battuto per arrivarci!",
         "PORTUGUÊS":"EXCELENTE! Você tem oficialmente o MAIOR CÉREBRO entre os seus AMIGOS! Vamos ver quem você superou para chegar até aqui!",
         "DEUTSCH":"AUSGEZEICHNET! Du hast offiziell das GRÖSSTE GEHIRN unter deinen FREUNDEN! Schauen wir mal, wen du besiegt hast, um hierher zu kommen!",
         "NEDERLANDS":"EXCELLENT! Je hebt officieel het GROOTSTE BREIN onder je VRIENDEN! Laten we eens kijken wie je hebt verslagen om hier te komen!",
         "SVENSKA":"UTMÄRKT! Du har officiellt den STÖRSTA HJÄRNAN bland dina VÄNNER! Låt oss se vem du slog för att komma hit!",
         "NORSK":"UTMERKET! Du har offisielt den STØRSTE HJERNEN blant vennene dine! La oss se hvem du slo for å komme hit!",
         "SUOMI":"ERINOMAISTA! Sinulla on virallisesti SUURIN AIVO ystäviesi joukossa! Katsotaanpa, kenet voisit voittaa päästäksesi tänne!",
         "POLSKI":"DOSKONALE! Oficjalnie masz NAJWIĘKSZY MÓZG spośród swoich PRZYJACIÓŁ! Zobaczmy, kogo pokonałeś, aby to osiągnąć!",
         "ΕΛΛΗΝΙΚΑ":"ΕΞΑΙΡΕΤΙΚΑ! Έχεις επίσημα τον ΜΕΓΑΛΥΤΕΡΟ ΕΓΚΕΦΑΛΟ ανάμεσα στους ΦΙΛΟΥΣ σου! Ας δούμε ποιον νίκησες για να φτάσεις εδώ!"
      };
      
      private static const SUMUP_TEXT:Object = {
         "ENGLISH":"Well done - That\'s it! Now let\'s SUM UP your score in each area and calculate the TOTAL SIZE of your BRAIN!",
         "ESPAÑOL":"¡Bien hecho, eso es todo! Ahora vamos a RESUMIR tu puntuación en cada área y calcular el TAMAÑO TOTAL de tu CEREBRO!",
         "FRANÇAIS":"Bien joué - C\'est fait ! Maintenant, RÉCAPITULONS ton score dans chaque domaine et calculons la TAILLE TOTALE de ton CERVEAU !",
         "ITALIANO":"Ben fatto - Ecco fatto! Ora RIASSUMIAMO il tuo punteggio in ogni area e calcoliamo la DIMENSIONE TOTALE del tuo CERVELLO!",
         "PORTUGUÊS":"Muito bem - É isso! Agora vamos RESUMIR sua pontuação em cada área e calcular o TAMANHO TOTAL do seu CÉREBRO!",
         "DEUTSCH":"Gut gemacht - Das war\'s! Jetzt FASSEN wir deine Punktzahl in jedem Bereich ZUSAMMEN und berechnen die GESAMTGRÖSSE deines GEHIRNS!",
         "NEDERLANDS":"Goed gedaan - Dat is het! Laten we nu je score in elk gebied SAMENVATTEN en de TOTALE GROOTTE van je BREIN berekenen!",
         "SVENSKA":"Bra gjort - Det var det! Nu ska vi SUMMERA dina poäng i varje område och räkna ut den TOTALA STORLEKEN på din HJÄRNA!",
         "NORSK":"Bra jobbet - Det var det! Nå skal vi OPPSUMMERE poengene dine i hvert område og beregne den TOTALE STØRRELSEN på HJERNEN din!",
         "SUOMI":"Hienoa - Siinä se! Nyt YHTEENVEDÄÄN pisteesi jokaiselta alueelta ja lasketaan AIVOJESI KOKONAISKOON!",
         "POLSKI":"Dobra robota - To wszystko! Teraz PODSUMUJEMY twój wynik w każdej dziedzinie i obliczymy CAŁKOWITY ROZMIAR twojego MÓZGU!",
         "ΕΛΛΗΝΙΚΑ":"Μπράβο - Αυτό ήταν! Τώρα ας ΣΥΝΟΨΙΣΟΥΜΕ τη βαθμολογία σου σε κάθε τομέα και ας υπολογίσουμε το ΣΥΝΟΛΙΚΟ ΜΕΓΕΘΟΣ του ΕΓΚΕΦΑΛΟΥ σου!"
      };
      
      private static const BRAINTYPE_TEXT_1:Object = {
         "ENGLISH":"OK, your results indicate that the SIZE of your BRAIN is ",
         "ESPAÑOL":"De acuerdo, tus resultados indican que el TAMAÑO de tu CEREBRO es ",
         "FRANÇAIS":"D\'accord, tes résultats indiquent que la TAILLE de ton CERVEAU est de ",
         "ITALIANO":"OK, i tuoi risultati indicano che la DIMENSIONE del tuo CERVELLO è ",
         "PORTUGUÊS":"OK, seus resultados indicam que o TAMANHO do seu CÉREBRO é ",
         "DEUTSCH":"OK, deine Ergebnisse zeigen, dass die GRÖSSE deines GEHIRNS ",
         "NEDERLANDS":"OK, je resultaten geven aan dat de GROOTTE van je BREIN ",
         "SVENSKA":"OK, dina resultat visar att STORLEKEN på din HJÄRNA är ",
         "NORSK":"OK, resultatene dine viser at STØRRELSEN på HJERNEN din er ",
         "SUOMI":"OK, tuloksesi osoittavat, että AIVOJESI KOKO on ",
         "POLSKI":"OK, twoje wyniki wskazują, że ROZMIAR twojego MÓZGU to ",
         "ΕΛΛΗΝΙΚΑ":"Εντάξει, τα αποτελέσματά σου δείχνουν ότι το ΜΕΓΕΘΟΣ του ΕΓΚΕΦΑΛΟΥ σου είναι "
      };
      
      private static const BRAINTYPE_TEXT_2:Object = {
         "ENGLISH":"cm3, which means you are the proud owner of a ",
         "ESPAÑOL":"cm3, lo que significa que eres el orgulloso dueño de un cerebro ",
         "FRANÇAIS":"cm3, ce qui signifie que tu es l\'heureux propriétaire d\'un cerveau ",
         "ITALIANO":"cm3, il che significa che sei il fiero possessore di un cervello ",
         "PORTUGUÊS":"cm3, o que significa que você é o orgulhoso dono de um cérebro ",
         "DEUTSCH":"cm3, was bedeutet, dass du stolzer Besitzer eines ",
         "NEDERLANDS":"cm3, wat betekent dat je de trotse eigenaar bent van een ",
         "SVENSKA":"cm3, vilket betyder att du stolt äger en ",
         "NORSK":"cm3, noe som betyr at du er den stolte eieren av en ",
         "SUOMI":"cm3, mikä tarkoittaa, että olet ylpeä omistaja ",
         "POLSKI":"cm3, co oznacza, że jesteś dumnym posiadaczem mózgu ",
         "ΕΛΛΗΝΙΚΑ":"cm3, που σημαίνει ότι είσαι ο περήφανος κάτοχος ενός εγκεφάλου "
      };
      
      private static const BRAINTYPE_TEXT_3:Object = {
         "ENGLISH":" brain!",
         "ESPAÑOL":"!",
         "FRANÇAIS":"!",
         "ITALIANO":"!",
         "PORTUGUÊS":"!",
         "DEUTSCH":"-Gehirns!",
         "NEDERLANDS":"-brein!",
         "SVENSKA":"-hjärna!",
         "NORSK":"-hjerne!",
         "SUOMI":"-aivoista!",
         "POLSKI":"!",
         "ΕΛΛΗΝΙΚΑ":"!"
      };
      
      private static const AMOEBA_TEXT:Object = {
         "ENGLISH":"I\'m sure there\'s something good to say about AMOEBAS, but I can\'t think of it. You should probably practice a little bit more!",
         "ESPAÑOL":"Estoy seguro de que hay algo bueno que decir sobre las AMEBAS, pero no se me ocurre. ¡Probablemente deberías practicar un poco más!",
         "FRANÇAIS":"Je suis sûr qu\'il y a quelque chose de bien à dire sur les AMIBES, mais je n\'y arrive pas. Tu devrais probablement t\'entraîner un peu plus !",
         "ITALIANO":"Sono sicuro che ci sia qualcosa di buono da dire sulle AMEBE, ma non mi viene in mente. Probabilmente dovresti allenarti un po\' di più!",
         "PORTUGUÊS":"Tenho certeza de que há algo de bom a dizer sobre as AMEBAS, mas não consigo pensar no quê. Você provavelmente deveria praticar um pouco mais!",
         "DEUTSCH":"Ich bin sicher, es gibt etwas Gutes über AMÖBEN zu sagen, aber mir fällt nichts ein. Du solltest wahrscheinlich noch ein bisschen mehr üben!",
         "NEDERLANDS":"Ik weet zeker dat er iets goeds te zeggen is over AMOEBEN, maar ik kan er niet opkomen. Je zou waarschijnlijk nog wat meer moeten oefenen!",
         "SVENSKA":"Jag är säker på att det finns något bra att säga om AMÖBOR, men jag kan inte komma på vad. Du borde nog träna lite mer!",
         "NORSK":"Jeg er sikker på at det finnes noe bra å si om AMØBER, men jeg kommer ikke på det. Du bør nok øve litt mer!",
         "SUOMI":"Olen varma, että on jotain hyvää sanottavaa ameeboista, mutta en keksi mitä. Sinun pitäisi luultavasti harjoitella vähän enemmän!",
         "POLSKI":"Jestem pewien, że można powiedzieć coś dobrego o AMEBACH, ale nic nie przychodzi mi do głowy. Powinieneś chyba poćwiczyć trochę więcej!",
         "ΕΛΛΗΝΙΚΑ":"Είμαι σίγουρος ότι υπάρχει κάτι καλό να πούμε για τις ΑΜΟΙΒΕΣ, αλλά δεν μπορώ να το σκεφτώ. Μάλλον θα πρέπει να εξασκηθείς λίγο περισσότερο!"
      };
      
      private static const EARTHWORM_TEXT:Object = {
         "ENGLISH":"EARTHWORMS are good for your garden soil, but they aren\'t exactly big thinkers. Why not practice a little bit more?",
         "ESPAÑOL":"LOS LOMBRICES son buenas para la tierra de tu jardín, pero no son exactamente grandes pensadores. ¿Por qué no practicas un poco más?",
         "FRANÇAIS":"LES VERS DE TERRE sont bons pour le sol de ton jardin, mais ils ne sont pas vraiment de grands penseurs. Pourquoi ne pas t\'entraîner un peu plus ?",
         "ITALIANO":"I LOMBRICHI sono buoni per il terreno del tuo giardino, ma non sono esattamente grandi pensatori. Perché non esercitarti un po\' di più?",
         "PORTUGUÊS":"AS MINHOCAS são boas para o solo do seu jardim, mas não são exatamente grandes pensadores. Por que não praticar um pouco mais?",
         "DEUTSCH":"REGENWÜRMER sind gut für deinen Gartenboden, aber sie sind nicht gerade große Denker. Warum nicht ein bisschen mehr üben?",
         "NEDERLANDS":"WORMS zijn goed voor je tuinbodem, maar ze zijn niet bepaald grote denkers. Waarom niet nog wat meer oefenen?",
         "SVENSKA":"MASKAR är bra för din trädgårdsjord, men de är inte precis stora tänkare. Varför inte träna lite mer?",
         "NORSK":"MARKER er gode for hagen din, men de er ikke akkurat store tenkere. Hvorfor ikke øve litt mer?",
         "SUOMI":"MAAPERÄN MATOt ovat hyviä puutarhasi maaperälle, mutta ne eivät ole kovin suuria ajattelijoita. Miksi et harjoittelisi vähän enemmän?",
         "POLSKI":"DŻDŻOWNICE są dobre dla gleby w twoim ogrodzie, ale nie są dokładnie wielkimi myślicielami. Dlaczego nie poćwiczyć trochę więcej?",
         "ΕΛΛΗΝΙΚΑ":"ΟΙ ΣΚΩΛΗΚΕΣ είναι καλές για το χώμα του κήπου σου, αλλά δεν είναι ακριβώς μεγάλοι στοχαστές. Γιατί να μην εξασκηθείς λίγο περισσότερο;"
      };
      
      private static const SNAIL_TEXT:Object = {
         "ENGLISH":"SNAILS are kind of cute... sort of, but their brains are still tiny. I\'m certain you can do better!",
         "ESPAÑOL":"LOS CARACOLES son algo lindos... más o menos, pero sus cerebros siguen siendo diminutos. ¡Estoy seguro de que puedes hacerlo mejor!",
         "FRANÇAIS":"LES ESCARGOTS sont plutôt mignons... en quelque sorte, mais leurs cerveaux sont encore minuscules. Je suis sûr que tu peux faire mieux !",
         "ITALIANO":"LE LUMACHE sono piuttosto carine... in un certo senso, ma i loro cervelli sono ancora minuscoli. Sono certo che puoi fare meglio!",
         "PORTUGUÊS":"OS CARACÓIS são meio fofos... de certa forma, mas seus cérebros ainda são pequenos. Tenho certeza de que você pode fazer melhor!",
         "DEUTSCH":"SCHNECKEN sind irgendwie niedlich... sozusagen, aber ihre Gehirne sind immer noch winzig. Ich bin sicher, dass du es besser machen kannst!",
         "NEDERLANDS":"SLIMMEN zijn best schattig... een beetje, maar hun hersenen zijn nog steeds klein. Ik weet zeker dat je het beter kunt doen!",
         "SVENSKA":"SNIGLAR är ganska söta... på ett sätt, men deras hjärnor är fortfarande små. Jag är säker på att du kan göra bättre ifrån dig!",
         "NORSK":"SNEGGER er litt søte... på en måte, men hjernene deres er fortsatt små. Jeg er sikker på at du kan gjøre det bedre!",
         "SUOMI":"ETANAT ovat vähän söpöjä... tosin, mutta niiden aivot ovat edelleen pieniä. Olen varma, että voit tehdä paremmin!",
         "POLSKI":"ŚLIMAKI są całkiem urocze... w pewnym sensie, ale ich mózgi są wciąż malutkie. Jestem pewien, że możesz zrobić lepiej!",
         "ΕΛΛΗΝΙΚΑ":"ΤΑ ΣΑΛΙΓΚΑΡΙΑ είναι κάπως χαριτωμένα... κάπως, αλλά οι εγκέφαλοί τους είναι ακόμα μικροσκοπικοί. Είμαι σίγουρος ότι μπορείς να τα καταφέρεις καλύτερα!"
      };
      
      private static const RAT_TEXT:Object = {
         "ENGLISH":"RATS are clever animals but I have a feeling you want to do better. Don\'t worry, with some more practice I\'m sure you\'ll get there!",
         "ESPAÑOL":"LAS RATAS son animales inteligentes, pero tengo la sensación de que quieres hacerlo mejor. No te preocupes, con un poco más de práctica estoy seguro de que lo lograrás.",
         "FRANÇAIS":"LES RATS sont des animaux intelligents, mais j\'ai l\'impression que tu veux faire mieux. Ne t\'inquiète pas, avec un peu plus d\'entraînement, je suis sûr que tu y arriveras !",
         "ITALIANO":"I TOPI sono animali intelligenti, ma ho la sensazione che tu voglia fare meglio. Non preoccuparti, con un po\' più di pratica sono sicuro che ce la farai!",
         "PORTUGUÊS":"OS RATOS são animais espertos, mas tenho a sensação de que você quer fazer melhor. Não se preocupe, com um pouco mais de prática tenho certeza de que você conseguirá!",
         "DEUTSCH":"RATTEN sind clevere Tiere, aber ich habe das Gefühl, dass du besser abschneiden willst. Keine Sorge, mit etwas mehr Übung wirst du es sicher schaffen!",
         "NEDERLANDS":"RATTEN zijn slimme dieren, maar ik heb het gevoel dat je het beter wilt doen. Maak je geen zorgen, met wat meer oefening kom je er zeker!",
         "SVENSKA":"RÅTTOR är kloka djur, men jag har en känsla av att du vill göra bättre ifrån dig. Oroa dig inte, med lite mer träning kommer du säkert dit!",
         "NORSK":"ROTTER er smarte dyr, men jeg har en følelse av at du vil gjøre det bedre. Ikke bekymre deg, med litt mer øvelse vil du nok klare det!",
         "SUOMI":"ROTAT ovat älykkäitä eläimiä, mutta minusta tuntuu, että haluat tehdä paremmin. Ei hätää, hieman enemmän harjoittelua ja olet varmasti siellä!",
         "POLSKI":"SZCZURY są sprytne, ale mam przeczucie, że chcesz zrobić lepiej. Nie martw się, z trochę więcej praktyki na pewno dasz radę!",
         "ΕΛΛΗΝΙΚΑ":"ΤΑ ΤΡΩΚΤΙΚΑ είναι έξυπνα ζώα, αλλά έχω την αίσθηση ότι θέλεις να τα πας καλύτερα. Μην ανησυχείς, με λίγη περισσότερη εξάσκηση είμαι σίγουρος ότι θα τα καταφέρεις!"
      };
      
      private static const CAT_TEXT:Object = {
         "ENGLISH":"CATS may have nine lives but their brains are only so-so, why don\'t you try and practice a bit to see if you can do better!",
         "ESPAÑOL":"LOS GATOS pueden tener nueve vidas, pero sus cerebros son solo mediocres. ¡Por qué no intentas practicar un poco para ver si puedes hacerlo mejor!",
         "FRANÇAIS":"LES CHATS peuvent avoir neuf vies, mais leurs cerveaux sont moyens. Pourquoi ne pas essayer et t\'entraîner un peu pour voir si tu peux faire mieux ?",
         "ITALIANO":"I GATTI possono avere nove vite, ma i loro cervelli sono solo così-così. Perché non provi a esercitarti un po\' per vedere se puoi fare meglio!",
         "PORTUGUÊS":"OS GATOS podem ter nove vidas, mas seus cérebros são apenas medianos. Por que não tenta praticar um pouco para ver se consegue melhorar?",
         "DEUTSCH":"KATZEN haben vielleicht neun Leben, aber ihre Gehirne sind nur mittelmäßig. Warum versuchst du nicht ein wenig zu üben, um zu sehen, ob du es besser machen kannst?",
         "NEDERLANDS":"KATTEN hebben misschien negen levens, maar hun hersenen zijn maar zo-zo. Waarom probeer je niet wat te oefenen om te zien of je het beter kunt doen?",
         "SVENSKA":"KATTER kan ha nio liv men deras hjärnor är bara sådär. Varför inte prova och öva lite för att se om du kan göra bättre ifrån dig?",
         "NORSK":"KATTER kan ha ni liv, men hjernene deres er bare så-som-så. Hvorfor ikke prøve å øve litt for å se om du kan gjøre det bedre?",
         "SUOMI":"KISSAT saattavat olla yhdeksän elämänsä arvoisia, mutta niiden aivot ovat vain keskinkertaiset. Miksi et kokeilisi harjoitella vähän nähdäksesi, voitko tehdä paremmin?",
         "POLSKI":"KOTY mogą mieć dziewięć żyć, ale ich mózgi są tylko przeciętne. Dlaczego nie spróbujesz trochę poćwiczyć, żeby zobaczyć, czy możesz zrobić lepiej?",
         "ΕΛΛΗΝΙΚΑ":"ΤΑ ΓΑΤΙΑ μπορεί να έχουν εννέα ζωές, αλλά οι εγκέφαλοί τους είναι μέτριοι. Γιατί να μην προσπαθήσεις και να εξασκηθείς λίγο για να δεις αν μπορείς να τα πας καλύτερα;"
      };
      
      private static const DOG_TEXT:Object = {
         "ENGLISH":"Well, who\'d not like to be a DOG! I suppose their brains could be bigger, though. You can do better with more practice!",
         "ESPAÑOL":"¡Bueno, a quién no le gustaría ser un PERRO! Supongo que sus cerebros podrían ser más grandes, aunque. ¡Puedes hacerlo mejor con más práctica!",
         "FRANÇAIS":"Eh bien, qui ne voudrait pas être un CHIEN ! Je suppose que leurs cerveaux pourraient être plus gros, cependant. Tu peux faire mieux avec un peu plus d\'entraînement !",
         "ITALIANO":"Beh, chi non vorrebbe essere un CANE! Suppongo che i loro cervelli potrebbero essere più grandi, comunque. Puoi fare meglio con un po\' più di pratica!",
         "PORTUGUÊS":"Bem, quem não gostaria de ser um CÃO! Suponho que seus cérebros poderiam ser maiores, porém. Você pode melhorar com mais prática!",
         "DEUTSCH":"Nun, wer würde nicht gerne ein HUND sein! Ich nehme an, ihre Gehirne könnten größer sein. Du kannst es mit etwas mehr Übung besser machen!",
         "NEDERLANDS":"Nou, wie zou er niet graag een HOND willen zijn! Ik veronderstel dat hun hersenen groter zouden kunnen zijn. Je kunt het beter doen met wat meer oefening!",
         "SVENSKA":"Nå, vem skulle inte vilja vara en HUND! Jag antar att deras hjärnor kunde vara större, men. Du kan göra bättre ifrån dig med mer träning!",
         "NORSK":"Vel, hvem ville vel ikke likt å være en HUND! Jeg antar at hjernene deres kunne vært større, men. Du kan gjøre det bedre med mer øvelse!",
         "SUOMI":"No, kuka ei haluaisi olla KOIRA! Oletan, että niiden aivot voisivat olla suuremmat. Voit tehdä paremmin lisää harjoittelua tekemällä!",
         "POLSKI":"Cóż, kto by nie chciał być PSEM! Przypuszczam, że ich mózgi mogłyby być większe, ale. Możesz zrobić lepiej z większą ilością praktyki!",
         "ΕΛΛΗΝΙΚΑ":"Λοιπόν, ποιος δεν θα ήθελε να είναι ΣΚΥΛΟΣ! Υποθέτω ότι οι εγκέφαλοί τους θα μπορούσαν να είναι μεγαλύτεροι. Μπορείς να τα πας καλύτερα με περισσότερη εξάσκηση!"
      };
      
      private static const GOAT_TEXT:Object = {
         "ENGLISH":"Imagine skipping up all those mountains! Not the worst brain size in the world but I\'m confident you can do better!",
         "ESPAÑOL":"¡Imagina saltar por todas esas montañas! No es el peor tamaño de cerebro del mundo, pero estoy seguro de que puedes hacerlo mejor.",
         "FRANÇAIS":"Imaginez sauter sur toutes ces montagnes ! Pas la pire taille de cerveau au monde, mais je suis sûr que tu peux faire mieux !",
         "ITALIANO":"Immagina di saltare su tutte quelle montagne! Non è la peggiore dimensione del cervello al mondo, ma sono sicuro che puoi fare meglio!",
         "PORTUGUÊS":"Imagine pular por todas aquelas montanhas! Não é o pior tamanho de cérebro do mundo, mas estou confiante de que você pode melhorar!",
         "DEUTSCH":"Stell dir vor, all diese Berge hinaufzuspringen! Nicht die schlechteste Gehirngröße der Welt, aber ich bin zuversichtlich, dass du es besser machen kannst!",
         "NEDERLANDS":"Stel je voor dat je al die bergen beklimt! Niet de slechtste hersengrootte ter wereld, maar ik weet zeker dat je het beter kunt doen!",
         "SVENSKA":"Föreställ dig att hoppa uppför alla dessa berg! Inte den sämsta hjärnans storlek i världen, men jag är säker på att du kan göra bättre ifrån dig!",
         "NORSK":"Tenk deg å hoppe opp alle disse fjellene! Ikke den verste hjernestørrelsen i verden, men jeg er sikker på at du kan gjøre det bedre!",
         "SUOMI":"Kuvittele hyppiväsi kaikkien näiden vuorten yli! Ei maailman huonoin aivokoko, mutta olen varma, että voit tehdä paremmin!",
         "POLSKI":"Wyobraź sobie skakanie po wszystkich tych górach! Nie najgorszy rozmiar mózgu na świecie, ale jestem pewien, że możesz zrobić lepiej!",
         "ΕΛΛΗΝΙΚΑ":"Φαντάσου να πηδάς πάνω από όλα αυτά τα βουνά! Δεν είναι το χειρότερο μέγεθος εγκεφάλου στον κόσμο, αλλά είμαι βέβαιος ότι μπορείς να τα πας καλύτερα!"
      };
      
      private static const CHIMP_TEXT:Object = {
         "ENGLISH":"They say CHIMPS can understand basic symbols and numbers. So not a bad score this but with practice you can do better!",
         "ESPAÑOL":"Dicen que los CHIMPANCÉS pueden entender símbolos y números básicos. No es una mala puntuación, pero con práctica puedes hacerlo mejor.",
         "FRANÇAIS":"On dit que les CHIMPANZÉS peuvent comprendre des symboles et des nombres de base. Pas un mauvais score, mais avec de l\'entraînement, tu peux faire mieux !",
         "ITALIANO":"Si dice che gli SCIMPANZÉ possano comprendere simboli e numeri di base. Non è un punteggio male, ma con la pratica puoi fare meglio!",
         "PORTUGUÊS":"Dizem que os CHIMPANZÉS conseguem entender símbolos e números básicos. Não é uma pontuação ruim, mas com prática você pode melhorar!",
         "DEUTSCH":"Man sagt, SCHIMPANSEN können grundlegende Symbole und Zahlen verstehen. Keine schlechte Punktzahl, aber mit Übung kannst du besser werden!",
         "NEDERLANDS":"Menen dat CHIMPANZÉS basisymbolen en cijfers kunnen begrijpen. Niet slecht gescoord, maar met oefening kan je beter doen!",
         "SVENSKA":"De säger att SCHIMPANSER kan förstå grundläggande symboler och siffror. Inte ett dåligt resultat, men med träning kan du göra bättre ifrån dig!",
         "NORSK":"De sier at SJIMPANSER kan forstå grunnleggende symboler og tall. Ikke en dårlig score, men med øvelse kan du gjøre det bedre!",
         "SUOMI":"Sanotaan, että SIMPANSIT voivat ymmärtää perussymboleja ja numeroita. Ei huono tulos, mutta harjoittelemalla voit tehdä paremmin!",
         "POLSKI":"Mówi się, że SZYMPIANSY rozumieją podstawowe symbole i liczby. Nie jest to zły wynik, ale z praktyką możesz zrobić lepiej!",
         "ΕΛΛΗΝΙΚΑ":"Λένε ότι οι ΧΙΜΠΑΝΤΖΗΔΕΣ μπορούν να καταλάβουν βασικά σύμβολα και αριθμούς. Δεν είναι κακό σκορ, αλλά με εξάσκηση μπορείς να τα πας καλύτερα!"
      };
      
      private static const GORILLA_TEXT:Object = {
         "ENGLISH":"GORILLAS are the largest living primates and considered highly intelligent. Looks to me like you can do better still!",
         "ESPAÑOL":"LOS GORILAS son los primates vivos más grandes y se consideran muy inteligentes. ¡Me parece que aún puedes hacerlo mejor!",
         "FRANÇAIS":"LES GORILLES sont les plus grands primates vivants et considérés comme très intelligents. Il me semble que tu peux encore faire mieux !",
         "ITALIANO":"I GORILLA sono i primati viventi più grandi e considerati molto intelligenti. Mi sembra che tu possa fare ancora meglio!",
         "PORTUGUÊS":"OS GORILAS são os maiores primatas vivos e considerados altamente inteligentes. Parece-me que você ainda pode melhorar!",
         "DEUTSCH":"GORILLAS sind die größten lebenden Primaten und gelten als sehr intelligent. Sieht für mich so aus, als könntest du noch besser werden!",
         "NEDERLANDS":"GORILLA\'S zijn de grootste levende primaten en worden als zeer intelligent beschouwd. Het lijkt erop dat je het nog beter kunt doen!",
         "SVENSKA":"GORILLOR är de största levande primaterna och anses vara mycket intelligenta. Jag tycker att du fortfarande kan göra bättre ifrån dig!",
         "NORSK":"GORILLAER er de største levende primatene og anses som svært intelligente. Ser for meg at du fortsatt kan gjøre det bedre!",
         "SUOMI":"GORILLAT ovat suurimpia eläviä kädellisiä ja niitä pidetään erittäin älykkäinä. Minusta näyttää siltä, että voit tehdä vielä paremmin!",
         "POLSKI":"GORILLAS to największe żyjące małpy człekokształtne i uważane za bardzo inteligentne. Wygląda na to, że możesz zrobić jeszcze lepiej!",
         "ΕΛΛΗΝΙΚΑ":"ΟΙ ΓΟΡΙΛΛΕΣ είναι οι μεγαλύτεροι ζωντανοί πρωτεύοντες και θεωρούνται πολύ ευφυείς. Μου φαίνεται ότι μπορείς να τα πας ακόμα καλύτερα!"
      };
      
      private static const MISSINGLINK_TEXT:Object = {
         "ENGLISH":"This early man had a relatively evolved brain. So not bad at all!",
         "ESPAÑOL":"¡Este hombre primitivo tenía un cerebro relativamente evolucionado! ¡Así que nada mal en absoluto!",
         "FRANÇAIS":"Cet homme primitif avait un cerveau relativement évolué. Donc pas mal du tout !",
         "ITALIANO":"Quest\'uomo primitivo aveva un cervello relativamente evoluto. Quindi non male affatto!",
         "PORTUGUÊS":"Este homem primitivo tinha um cérebro relativamente evoluído. Então, nada mal mesmo!",
         "DEUTSCH":"Dieser Frühmensch hatte ein relativ entwickeltes Gehirn. Also gar nicht schlecht!",
         "NEDERLANDS":"Deze vroege mens had een relatief ontwikkeld brein. Dus helemaal niet slecht!",
         "SVENSKA":"Denna tidiga människa hade en relativt utvecklad hjärna. Så inte alls dåligt!",
         "NORSK":"Denne tidlige mannen hadde en relativt utviklet hjerne. Så ikke dårlig i det hele tatt!",
         "SUOMI":"Tällä varhaisella ihmisellä oli suhteellisen kehittynyt aivot. Ei ollenkaan huono!",
         "POLSKI":"Ten wczesny człowiek miał stosunkowo rozwinięty mózg. Więc wcale nieźle!",
         "ΕΛΛΗΝΙΚΑ":"Αυτός ο πρώιμος άνθρωπος είχε σχετικά εξελιγμένο εγκέφαλο. Οπότε καθόλου άσχημα!"
      };
      
      private static const NEANDERTHAL_TEXT:Object = {
         "ENGLISH":"The NEANDERTHAL were the geniuses of their time - they even controlled fire. This is a pretty good score! Keep practicing!",
         "ESPAÑOL":"¡Los NEANDERTALES fueron los genios de su época, incluso controlaban el fuego! ¡Esta es una puntuación bastante buena! ¡Sigue practicando!",
         "FRANÇAIS":"Les NÉANDERTALIENS étaient les génies de leur époque - ils maîtrisaient même le feu. C\'est un score plutôt bon ! Continue de t\'entraîner !",
         "ITALIANO":"I NEANDERTAL erano i geni del loro tempo - controllavano persino il fuoco. Questo è un punteggio abbastanza buono! Continua a esercitarti!",
         "PORTUGUÊS":"Os NEANDERTAIS eram os gênios de seu tempo - eles até controlavam o fogo. Esta é uma pontuação bastante boa! Continue praticando!",
         "DEUTSCH":"Die NEANDERTALER waren die Genies ihrer Zeit – sie beherrschten sogar das Feuer. Das ist eine ziemlich gute Punktzahl! Weiter üben!",
         "NEDERLANDS":"De NEANDERTALERS waren de genieën van hun tijd - ze beheersten zelfs het vuur. Dit is een behoorlijk goede score! Blijf oefenen!",
         "SVENSKA":"NEANDERTALERNA var tidens genier – de kontrollerade till och med eld. Det här är en ganska bra poäng! Fortsätt träna!",
         "NORSK":"NEANDERTALERNE var geniene på sin tid – de kontrollerte til og med ild. Dette er en ganske god poengsum! Fortsett å øve!",
         "SUOMI":"NEANDERTALILAISET olivat aikansa neroja – he hallitsivat jopa tulen. Tämä on melko hyvä tulos! Jatka harjoittelua!",
         "POLSKI":"NEANDERTALCY byli geniuszami swoich czasów – potrafili nawet kontrolować ogień. To całkiem dobry wynik! Kontynuuj ćwiczenia!",
         "ΕΛΛΗΝΙΚΑ":"ΟΙ ΝΕΑΝΤΕΡΤΑΛ ήταν οι ιδιοφυΐες της εποχής τους - ακόμη και ελέγχαν τη φωτιά. Αυτό είναι ένα αρκετά καλό σκορ! Συνέχισε να εξασκείσαι!"
      };
      
      private static const AVERAGEJOE_TEXT:Object = {
         "ENGLISH":"Not amazing, but not too shabby either. Being an AVERAGE JOE is nothing to be ashamed of!",
         "ESPAÑOL":"No es asombroso, pero tampoco está tan mal. ¡Ser una PERSONA PROMEDIO no es nada de lo que avergonzarse!",
         "FRANÇAIS":"Pas incroyable, mais pas trop mal non plus. Être une PERSONNE MOYENNE n\'est rien dont il faut avoir honte !",
         "ITALIANO":"Non è eccezionale, ma neanche troppo male. Essere una PERSONA MEDIA non è nulla di cui vergognarsi!",
         "PORTUGUÊS":"Não é incrível, mas também não é tão ruim. Ser uma PESSOA MÉDIA não é nada para se envergonhar!",
         "DEUTSCH":"Nicht fantastisch, aber auch nicht schlecht. Eine DURCHSCHNITTLICHE PERSON zu sein ist nichts, wofür man sich schämen müsste!",
         "NEDERLANDS":"Niet geweldig, maar ook niet slecht. Een GEMIDDELDE PERSOON zijn is niets om je voor te schamen!",
         "SVENSKA":"Inte fantastiskt, men inte dåligt heller. Att vara en GENOMSNITTLIG PERSON är inget att skämmas för!",
         "NORSK":"Ikke fantastisk, men heller ikke så verst. Å være en GJENNOMSNITTLIG PERSON er ingenting å skamme seg over!",
         "SUOMI":"Ei ihmeellinen, mutta ei myöskään huono. Olla KESKIMÄINEN HENKILÖ ei ole mitään mistä pitäisi hävetä!",
         "POLSKI":"Nie powalające, ale też nie źle. Bycie PRZECIĘTNĄ OSOBĄ nie jest czymś, czego trzeba się wstydzić!",
         "ΕΛΛΗΝΙΚΑ":"Όχι καταπληκτικό, αλλά ούτε άσχημο. Το να είσαι ΜΕΣΟΣ ΑΝΘΡΩΠΟΣ δεν είναι κάτι για το οποίο πρέπει να ντρέπεσαι!"
      };
      
      private static const GEEK_TEXT:Object = {
         "ENGLISH":"Your GEEK brain shows a lot of promise! With a bit of practice you\'ll graduate to become a NERD one day!",
         "ESPAÑOL":"¡Tu cerebro GEEK muestra mucho potencial! ¡Con un poco de práctica algún día llegarás a ser un NERD!",
         "FRANÇAIS":"Ton cerveau GEEK montre beaucoup de potentiel ! Avec un peu de pratique, tu deviendras un NERD un jour !",
         "ITALIANO":"Il tuo cervello GEEK mostra molto potenziale! Con un po\' di pratica un giorno diventerai un NERD!",
         "PORTUGUÊS":"Seu cérebro GEEK mostra muito potencial! Com um pouco de prática, você se tornará um NERD algum dia!",
         "DEUTSCH":"Dein GEEK-Gehirn zeigt viel Potenzial! Mit etwas Übung wirst du eines Tages ein NERD werden!",
         "NEDERLANDS":"Je GEEK-brein toont veel potentieel! Met wat oefening zul je op een dag een NERD worden!",
         "SVENSKA":"Din GEEK-hjärna visar mycket potential! Med lite träning kommer du en dag att bli en NERD!",
         "NORSK":"Din GEEK-hjerne viser mye potensial! Med litt øvelse vil du en dag bli en NERD!",
         "SUOMI":"GEEK-aivosi osoittaa paljon potentiaalia! Harjoittelemalla tulet jonain päivänä NERDiksi!",
         "POLSKI":"Twój GEEK mózg pokazuje dużo potencjału! Z odrobiną praktyki pewnego dnia zostaniesz NERDem!",
         "ΕΛΛΗΝΙΚΑ":"Ο GEEK εγκέφαλός σου δείχνει πολλά υποσχόμενα! Με λίγη εξάσκηση μια μέρα θα γίνεις NERD!"
      };
      
      private static const NERD_TEXT:Object = {
         "ENGLISH":"Hey - pretty clever are we? NERDS will one day rule the universe! Keep practising and you may become a SCHOLAR!",
         "ESPAÑOL":"¡Eh, bastante listo, verdad? ¡Los NERDS algún día dominarán el universo! ¡Sigue practicando y podrías llegar a ser un ERUDITO!",
         "FRANÇAIS":"Hé - assez malin, non ? Les NERDS régneront un jour sur l\'univers ! Continue de t\'entraîner et tu pourrais devenir un SAVANT !",
         "ITALIANO":"Ehi - abbastanza intelligenti, vero? I NERD un giorno domineranno l\'universo! Continua a esercitarti e potresti diventare uno STUDIOSO!",
         "PORTUGUÊS":"Ei - bem esperto, hein? Os NERDS um dia governarão o universo! Continue praticando e você pode se tornar um ERUDITO!",
         "DEUTSCH":"Hey - ziemlich clever, was? NERDS werden eines Tages das Universum beherrschen! Übe weiter und vielleicht wirst du ein GELEHRTER!",
         "NEDERLANDS":"Hé - behoorlijk slim hè? NERDS zullen op een dag het universum regeren! Blijf oefenen en je kunt een GELEERDE worden!",
         "SVENSKA":"Hej - ganska smart, va? NERDS kommer en dag att härska över universum! Fortsätt träna och du kan bli en LÄRDOMSRIK!",
         "NORSK":"Hei - ganske smart, ikke sant? NERDS vil en dag herske over universet! Fortsett å øve og du kan bli en LÆRD!",
         "SUOMI":"Hei - melko fiksu, eikö? NERDit hallitsevat joskus universumia! Jatka harjoittelua, niin voit tulla TUTKIJAKSI!",
         "POLSKI":"Hej - całkiem bystry, co? NERDY pewnego dnia będą rządzić wszechświatem! Ćwicz dalej, a możesz zostać UCZONYM!",
         "ΕΛΛΗΝΙΚΑ":"Ε, αρκετά έξυπνος είσαι, ε? Οι NERDS μια μέρα θα κυβερνήσουν το σύμπαν! Συνέχισε την εξάσκηση και μπορεί να γίνεις ΜΑΘΗΜΑΤΙΚΟΣ!"
      };
      
      private static const SCHOLAR_TEXT:Object = {
         "ENGLISH":"A SCHOLAR in our midst - congratulations on a job well done! I look forward to seeing what your brain is capable of!",
         "ESPAÑOL":"¡Un ERUDITO entre nosotros! ¡Felicidades por un trabajo bien hecho! ¡Estoy deseando ver de lo que tu cerebro es capaz!",
         "FRANÇAIS":"Un SAVANT parmi nous - félicitations pour ce travail bien fait ! J\'ai hâte de voir ce dont ton cerveau est capable !",
         "ITALIANO":"Uno STUDIOSO tra noi - congratulazioni per il lavoro ben fatto! Non vedo l\'ora di vedere di cosa è capace il tuo cervello!",
         "PORTUGUÊS":"Um ERUDITO entre nós - parabéns pelo trabalho bem feito! Estou ansioso para ver do que seu cérebro é capaz!",
         "DEUTSCH":"Ein GELEHRTER unter uns - herzlichen Glückwunsch zu guter Arbeit! Ich freue mich darauf zu sehen, wozu dein Gehirn fähig ist!",
         "NEDERLANDS":"Een GELEERDE onder ons - gefeliciteerd met het goed uitgevoerde werk! Ik kijk ernaar uit om te zien waartoe je brein in staat is!",
         "SVENSKA":"En LÄRDOMSRIK bland oss - grattis till ett väl utfört arbete! Jag ser fram emot att se vad din hjärna klarar av!",
         "NORSK":"En LÆRD blant oss - gratulerer med godt utført arbeid! Jeg ser frem til å se hva hjernen din er i stand til!",
         "SUOMI":"TUTKIJA joukossamme - onneksi olkoon hyvin tehdystä työstä! Odotan innolla, mihin aivosi pystyvät!",
         "POLSKI":"UCZONY w naszym gronie - gratulacje za dobrze wykonaną pracę! Nie mogę się doczekać, aby zobaczyć, do czego twój mózg jest zdolny!",
         "ΕΛΛΗΝΙΚΑ":"ΕΝΑΣ ΜΑΘΗΜΑΤΙΚΟΣ ανάμεσά μας - συγχαρητήρια για την εξαιρετική δουλειά! Ανυπομονώ να δω τι μπορεί να κάνει ο εγκέφαλός σου!"
      };
      
      private static const SCIENTIST_TEXT:Object = {
         "ENGLISH":"Wow, Pretty smart! A SCIENTIST brain is something to be very proud of! Most people don\'t get a score this high!",
         "ESPAÑOL":"¡Guau, bastante inteligente! ¡Un cerebro de CIENTÍFICO es algo de lo que estar muy orgulloso! ¡La mayoría de la gente no alcanza una puntuación tan alta!",
         "FRANÇAIS":"Wow, assez intelligent ! Un cerveau de SCIENTIFIQUE est quelque chose dont il faut être très fier ! La plupart des gens n\'obtiennent pas un score aussi élevé !",
         "ITALIANO":"Wow, abbastanza intelligente! Un cervello da SCIENZIATO è qualcosa di cui essere molto orgogliosi! La maggior parte delle persone non raggiunge un punteggio così alto!",
         "PORTUGUÊS":"Uau, bastante inteligente! Um cérebro de CIENTISTA é algo para se orgulhar muito! A maioria das pessoas não consegue uma pontuação tão alta!",
         "DEUTSCH":"Wow, ziemlich klug! Ein WISSENSCHAFTLER-Gehirn ist etwas, worauf man sehr stolz sein kann! Die meisten Leute erreichen nicht so eine hohe Punktzahl!",
         "NEDERLANDS":"Wauw, best slim! Een WETENSCHAPPELIJK brein is iets om erg trots op te zijn! De meeste mensen halen deze hoge score niet!",
         "SVENSKA":"Wow, ganska smart! En FORSKARE-hjärna är något att vara väldigt stolt över! De flesta får inte ett så högt poäng!",
         "NORSK":"Wow, ganske smart! Et FORSKER-hjerne er noe å være veldig stolt av! De fleste får ikke en så høy poengsum!",
         "SUOMI":"Vau, melko fiksu! TIETEILIJÄ-aivot ovat jotain, mistä voi olla erittäin ylpeä! Useimmat ihmiset eivät saa näin korkeaa pistemäärää!",
         "POLSKI":"Wow, całkiem bystry! Mózg NAUKOWCA to coś, z czego można być bardzo dumnym! Większość ludzi nie osiąga tak wysokiego wyniku!",
         "ΕΛΛΗΝΙΚΑ":"Ουάου, αρκετά έξυπνος! Ο εγκέφαλος ενός ΕΠΙΣΤΗΜΟΝΑ είναι κάτι που πρέπει να είσαι πολύ περήφανος! Οι περισσότεροι δεν παίρνουν τόσο υψηλό σκορ!"
      };
      
      private static const GENIUS_TEXT:Object = {
         "ENGLISH":"You are a GENIUS! And a holder of the biggest brain type possible in humans today! Well done - you should be proud!",
         "ESPAÑOL":"¡Eres un GENIO! ¡Y posees el tipo de cerebro más grande posible en los humanos de hoy! ¡Bien hecho, deberías estar orgulloso!",
         "FRANÇAIS":"Tu es un GÉNIE ! Et tu possèdes le plus grand type de cerveau possible chez l\'homme aujourd\'hui ! Bien joué - tu devrais être fier !",
         "ITALIANO":"Sei un GENIO! E possiedi il tipo di cervello più grande possibile negli esseri umani oggi! Ben fatto - dovresti essere orgoglioso!",
         "PORTUGUÊS":"Você é um GÊNIO! E possui o maior tipo de cérebro possível nos humanos hoje! Bem feito - você deve estar orgulhoso!",
         "DEUTSCH":"Du bist ein GENIE! Und besitzt den größten heute bei Menschen möglichen Gehirntyp! Gut gemacht – du solltest stolz sein!",
         "NEDERLANDS":"Je bent een GENIE! En bezit het grootste hersentype dat momenteel bij mensen mogelijk is! Goed gedaan – je mag trots zijn!",
         "SVENSKA":"Du är ett GENI! Och har den största hjärntypen som finns hos människor idag! Bra gjort – du bör vara stolt!",
         "NORSK":"Du er et GENI! Og har den største hjernetypen som er mulig hos mennesker i dag! Bra gjort – du bør være stolt!",
         "SUOMI":"Olet GEENI! Ja sinulla on suurin mahdollinen aivotyyppi ihmisillä tänään! Hyvin tehty – sinun pitäisi olla ylpeä!",
         "POLSKI":"Jesteś GENIUSZEM! I posiadasz największy możliwy typ mózgu u ludzi dzisiaj! Dobrze zrobione – powinieneś być dumny!",
         "ΕΛΛΗΝΙΚΑ":"Είσαι ΕΥΦΥΗΣ! Και κατέχεις τον μεγαλύτερο τύπο εγκεφάλου που υπάρχει σήμερα στους ανθρώπους! Μπράβο – πρέπει να είσαι περήφανος!"
      };
      
      private static const SPACEACE_TEXT:Object = {
         "ENGLISH":"You\'re ahead of your time! Humans shouldn\'t have your kind of brain capacity this century. Did you arrive by time machine?",
         "ESPAÑOL":"¡Estás adelantado a tu tiempo! Los humanos no deberían tener tu tipo de capacidad cerebral en este siglo. ¿Llegaste en una máquina del tiempo?",
         "FRANÇAIS":"Tu es en avance sur ton temps ! Les humains ne devraient pas avoir ce type de capacité cérébrale ce siècle-ci. Es-tu arrivé par une machine à remonter le temps ?",
         "ITALIANO":"Sei avanti con i tempi! Gli esseri umani non dovrebbero avere questo tipo di capacità cerebrale in questo secolo. Sei arrivato con una macchina del tempo?",
         "PORTUGUÊS":"Você está à frente do seu tempo! Os humanos não deveriam ter sua capacidade cerebral neste século. Você chegou por uma máquina do tempo?",
         "DEUTSCH":"Du bist deiner Zeit voraus! Menschen sollten diese Art von Gehirnkapazität in diesem Jahrhundert nicht haben. Bist du mit einer Zeitmaschine gekommen?",
         "NEDERLANDS":"Je bent je tijd vooruit! Mensen zouden deze soort hersencapaciteit in deze eeuw niet moeten hebben. Ben je met een tijdmachine gekomen?",
         "SVENSKA":"Du är före din tid! Människor borde inte ha denna typ av hjärnkapacitet detta århundrade. Kom du med en tidsmaskin?",
         "NORSK":"Du ligger foran din tid! Mennesker burde ikke ha denne typen hjernekapasitet dette århundret. Kom du med en tidsmaskin?",
         "SUOMI":"Olet aikasi edellä! Ihmisten ei pitäisi omata tällaista aivokapasiteettia tällä vuosisadalla. Tulitko aikakoneella?",
         "POLSKI":"Jesteś przed swoim czasem! Ludzie nie powinni mieć takiej pojemności mózgu w tym stuleciu. Przybyłeś wehikułem czasu?",
         "ΕΛΛΗΝΙΚΑ":"Είσαι μπροστά από την εποχή σου! Οι άνθρωποι δεν θα έπρεπε να έχουν τέτοια εγκεφαλική ικανότητα αυτόν τον αιώνα. Ήρθες με χρονομηχανή;"
      };
      
      private static const CYBORG_TEXT:Object = {
         "ENGLISH":"Woah, you are a CYBORG! Man-machine combinations are almost unbeatable! Resistance is futile!",
         "ESPAÑOL":"¡Vaya, eres un CYBORG! ¡Las combinaciones hombre-máquina son casi invencibles! ¡La resistencia es inútil!",
         "FRANÇAIS":"Wow, tu es un CYBORG ! Les combinaisons homme-machine sont presque invincibles ! La résistance est futile !",
         "ITALIANO":"Wow, sei un CYBORG! Le combinazioni uomo-macchina sono quasi imbattibili! La resistenza è inutile!",
         "PORTUGUÊS":"Uau, você é um CYBORG! Combinações homem-máquina são quase imbatíveis! Resistência é inútil!",
         "DEUTSCH":"Wow, du bist ein CYBORG! Mensch-Maschine-Kombinationen sind fast unschlagbar! Widerstand ist zwecklos!",
         "NEDERLANDS":"Wauw, je bent een CYBORG! Mens-machine combinaties zijn bijna onverslaanbaar! Weerstand is nutteloos!",
         "SVENSKA":"Woah, du är en CYBORG! Människa-maskin kombinationer är nästan oslagbara! Motstånd är lönlöst!",
         "NORSK":"Woah, du er en CYBORG! Menneske-maskin kombinasjoner er nesten uslåelige! Motstand er nytteløst!",
         "SUOMI":"Vau, olet CYBORG! Ihmis-kone-yhdistelmät ovat lähes voittamattomia! Vastustus on turhaa!",
         "POLSKI":"Wow, jesteś CYBORGIEM! Połączenia człowiek-maszyna są prawie nie do pokonania! Opór jest daremny!",
         "ΕΛΛΗΝΙΚΑ":"Ουάου, είσαι CYBORG! Ο συνδυασμός ανθρώπου-μηχανής είναι σχεδόν ανίκητος! Η αντίσταση είναι μάταιη!"
      };
      
      private static const ALIEN_TEXT:Object = {
         "ENGLISH":"Welcome to Earth, visitor! Your score is remarkable - very WELL DONE! Thanks for popping by and safe intergalactic travels!",
         "ESPAÑOL":"¡Bienvenido a la Tierra, visitante! ¡Tu puntuación es notable, muy BIEN HECHO! ¡Gracias por pasar y que tengas un seguro viaje intergaláctico!",
         "FRANÇAIS":"Bienvenue sur Terre, visiteur ! Ton score est remarquable - très BIEN FAIT ! Merci de votre passage et bon voyage intergalactique !",
         "ITALIANO":"Benvenuto sulla Terra, visitatore! Il tuo punteggio è notevole - ben FATTO! Grazie per essere passato e buon viaggio intergalattico!",
         "PORTUGUÊS":"Bem-vindo à Terra, visitante! Sua pontuação é notável - muito BEM FEITO! Obrigado por passar e boas viagens intergalácticas!",
         "DEUTSCH":"Willkommen auf der Erde, Besucher! Deine Punktzahl ist bemerkenswert – sehr GUT GEMACHT! Danke für deinen Besuch und sichere intergalaktische Reisen!",
         "NEDERLANDS":"Welkom op Aarde, bezoeker! Je score is opmerkelijk - zeer GOED GEDAAN! Bedankt voor je bezoek en veilige intergalactische reizen!",
         "SVENSKA":"Välkommen till jorden, besökare! Din poäng är anmärkningsvärd – mycket BRA GJORT! Tack för besöket och säkra intergalaktiska resor!",
         "NORSK":"Velkommen til Jorden, besøkende! Din poengsum er bemerkelsesverdig – veldig BRA GJORT! Takk for besøket og trygg intergalaktisk reise!",
         "SUOMI":"Tervetuloa Maahan, vierailija! Pistemääräsi on merkittävä – erittäin HYVIN TEHTY! Kiitos vierailusta ja turvallisia intergalaktisia matkoja!",
         "POLSKI":"Witaj na Ziemi, gościu! Twój wynik jest godny podziwu – bardzo DOBRZE! Dzięki za wizytę i bezpiecznych podróży międzygalaktycznych!",
         "ΕΛΛΗΝΙΚΑ":"Καλώς ήρθες στη Γη, επισκέπτη! Η βαθμολογία σου είναι αξιοσημείωτη – πολύ ΚΑΛΑ ΚΑΝΕΙΣ! Ευχαριστώ που πέρασες και ασφαλή διαστρικά ταξίδια!"
      };
      
      private static const SQUIDLIAN_TEXT:Object = {
         "ENGLISH":"Greetings, master SQUIDLIAN! you flatter us humble earthlings with your mighty brain! Congratulations!",
         "ESPAÑOL":"¡Saludos, maestro SQUIDLIAN! ¡Nos halagas a nosotros, humildes terrícolas, con tu poderoso cerebro! ¡Felicidades!",
         "FRANÇAIS":"Salutations, maître SQUIDLIAN ! Vous flattez nous, humbles terriens, avec votre puissant cerveau ! Félicitations !",
         "ITALIANO":"Saluti, maestro SQUIDLIAN! Ci lusinghi, umili terrestri, con il tuo potente cervello! Congratulazioni!",
         "PORTUGUÊS":"Saudações, mestre SQUIDLIAN! Você nos lisonjeia, humildes terráqueos, com seu poderoso cérebro! Parabéns!",
         "DEUTSCH":"Grüße, Meister SQUIDLIAN! Du schmeichelst uns bescheidenen Erdenbewohnern mit deinem mächtigen Gehirn! Herzlichen Glückwunsch!",
         "NEDERLANDS":"Groeten, meester SQUIDLIAN! Je vleit ons, nederige aardbewoners, met je machtige brein! Gefeliciteerd!",
         "SVENSKA":"Hälsningar, mästare SQUIDLIAN! Du smickrar oss ödmjuka jordbor med din mäktiga hjärna! Grattis!",
         "NORSK":"Hilsener, mester SQUIDLIAN! Du smigrer oss ydmyke jordboere med din mektige hjerne! Gratulerer!",
         "SUOMI":"Tervehdys, mestari SQUIDLIAN! Sinä imartelet meitä nöyriä maankulkijoita voimakkaalla aivoillasi! Onnittelut!",
         "POLSKI":"Pozdrowienia, mistrzu SQUIDLIAN! Pochlebiasz nam, skromnym ziemianom, swoim potężnym mózgiem! Gratulacje!",
         "ΕΛΛΗΝΙΚΑ":"Χαιρετισμούς, δάσκαλε SQUIDLIAN! Μας κολακεύεις, ταπεινούς γήινους, με τον ισχυρό σου εγκέφαλο! Συγχαρητήρια!"
      };
      
      private static const BITBOT_TEXT:Object = {
         "ENGLISH":"Wow! You are a BITBOT! No wonder you\'re so fast - you\'re a MACHINE! An excellent result - congratulations!",
         "ESPAÑOL":"¡Guau! ¡Eres un BITBOT! No es de extrañar que seas tan rápido: ¡eres una MÁQUINA! Un resultado excelente, ¡felicidades!",
         "FRANÇAIS":"Wow ! Tu es un BITBOT ! Pas étonnant que tu sois si rapide - tu es une MACHINE ! Un excellent résultat - félicitations !",
         "ITALIANO":"Wow! Sei un BITBOT! Non c\'è da meravigliarsi se sei così veloce - sei una MACCHINA! Ottimo risultato - congratulazioni!",
         "PORTUGUÊS":"Uau! Você é um BITBOT! Não é de admirar que você seja tão rápido - você é uma MÁQUINA! Um excelente resultado - parabéns!",
         "DEUTSCH":"Wow! Du bist ein BITBOT! Kein Wunder, dass du so schnell bist – du bist eine MASCHINE! Ein ausgezeichnetes Ergebnis – Glückwunsch!",
         "NEDERLANDS":"Wauw! Je bent een BITBOT! Geen wonder dat je zo snel bent - je bent een MACHINE! Een uitstekend resultaat - gefeliciteerd!",
         "SVENSKA":"Wow! Du är en BITBOT! Ingen wonder att du är så snabb - du är en MASKIN! Ett utmärkt resultat - grattis!",
         "NORSK":"Wow! Du er en BITBOT! Ikke rart du er så rask - du er en MASKIN! Et utmerket resultat - gratulerer!",
         "SUOMI":"Vau! Olet BITBOT! Ei ihme, että olet niin nopea – olet KONE! Erinomainen tulos – onnittelut!",
         "POLSKI":"Wow! Jesteś BITBOTEM! Nic dziwnego, że jesteś tak szybki – jesteś MASZYNĄ! Doskonały wynik – gratulacje!",
         "ΕΛΛΗΝΙΚΑ":"Ουάου! Είσαι BITBOT! Δεν είναι περίεργο που είσαι τόσο γρήγορος – είσαι ΜΗΧΑΝΗ! Εξαιρετικό αποτέλεσμα – συγχαρητήρια!"
      };
      
      private static const SPACEBOT_TEXT:Object = {
         "ENGLISH":"Huh, an RX-711 SPACEBOT?! I knew you were quick, but didn\'t realise you were a machine! Well done!",
         "ESPAÑOL":"¿Eh, un RX-711 SPACEBOT?! Sabía que eras rápido, ¡pero no me di cuenta de que eras una máquina! ¡Bien hecho!",
         "FRANÇAIS":"Hein, un RX-711 SPACEBOT ?! Je savais que tu étais rapide, mais je n\'avais pas réalisé que tu étais une machine ! Bien joué !",
         "ITALIANO":"Eh, un RX-711 SPACEBOT?! Sapevo che eri veloce, ma non mi ero reso conto che fossi una macchina! Ben fatto!",
         "PORTUGUÊS":"Hã, um RX-711 SPACEBOT?! Eu sabia que você era rápido, mas não percebi que você era uma máquina! Bem feito!",
         "DEUTSCH":"Huh, ein RX-711 SPACEBOT?! Ich wusste, dass du schnell bist, aber ich habe nicht gemerkt, dass du eine Maschine bist! Gut gemacht!",
         "NEDERLANDS":"Hè, een RX-711 SPACEBOT?! Ik wist dat je snel was, maar ik had niet door dat je een machine was! Goed gedaan!",
         "SVENSKA":"Va, en RX-711 SPACEBOT?! Jag visste att du var snabb, men hade inte insett att du var en maskin! Bra gjort!",
         "NORSK":"Huh, en RX-711 SPACEBOT?! Jeg visste at du var rask, men innså ikke at du var en maskin! Bra gjort!",
         "SUOMI":"Huh, RX-711 SPACEBOT?! Tiesin, että olet nopea, mutta en tajunnut, että olet kone! Hyvin tehty!",
         "POLSKI":"Hę, RX-711 SPACEBOT?! Wiedziałem, że jesteś szybki, ale nie zdawałem sobie sprawy, że jesteś maszyną! Dobrze zrobione!",
         "ΕΛΛΗΝΙΚΑ":"Χμ, ένας RX-711 SPACEBOT?! Ήξερα ότι ήσουν γρήγορος, αλλά δεν συνειδητοποίησα ότι ήσουν μηχανή! Μπράβο!"
      };
      
      private static const CALCUBOT_TEXT:Object = {
         "ENGLISH":"I\'m speechless! A CALCUBOT on my show?! I always knew it! No way you could be anything else! Well done!",
         "ESPAÑOL":"¡Estoy sin palabras! ¿Un CALCUBOT en mi programa?! ¡Siempre lo supe! ¡No podrías ser otra cosa! ¡Bien hecho!",
         "FRANÇAIS":"Je suis sans voix ! Un CALCUBOT dans mon émission ?! Je l\'ai toujours su ! Il n\'y a pas moyen que tu sois autre chose ! Bien joué !",
         "ITALIANO":"Sono senza parole! Un CALCUBOT nel mio show?! L\'ho sempre saputo! Non potresti essere altro! Ben fatto!",
         "PORTUGUÊS":"Estou sem palavras! Um CALCUBOT no meu show?! Sempre soube disso! De jeito nenhum você poderia ser outra coisa! Bem feito!",
         "DEUTSCH":"Ich bin sprachlos! Ein CALCUBOT in meiner Show?! Ich wusste es immer! Du könntest unmöglich etwas anderes sein! Gut gemacht!",
         "NEDERLANDS":"Ik ben sprakeloos! Een CALCUBOT in mijn show?! Dat wist ik altijd al! Je kunt onmogelijk iets anders zijn! Goed gedaan!",
         "SVENSKA":"Jag är mållös! En CALCUBOT i min show?! Jag har alltid vetat det! Du kan omöjligt vara något annat! Bra gjort!",
         "NORSK":"Jeg er målløs! En CALCUBOT i showet mitt?! Jeg har alltid visst det! Du kan umulig være noe annet! Bra gjort!",
         "SUOMI":"Olen sanaton! CALCUBOT ohjelmassani?! Olen aina tiennyt sen! Et voi olla mikään muu! Hyvin tehty!",
         "POLSKI":"Jestem bez słów! CALCUBOT w moim programie?! Zawsze to wiedziałem! Nie mogłeś być niczym innym! Dobrze zrobione!",
         "ΕΛΛΗΝΙΚΑ":"Έμεινα άφωνος! Ένας CALCUBOT στο σόου μου?! Το ήξερα πάντα! Δεν θα μπορούσες να είσαι κάτι άλλο! Μπράβο!"
      };
      
      private static const ENCEPHALOBOT_TEXT:Object = {
         "ENGLISH":"ASTONISHING! Ladies and Gentlemen, our contestant, is an ENCEPHALOBOT! You can ask for autographs later. Well done!",
         "ESPAÑOL":"¡ASOMBROSO! Señoras y señores, nuestro concursante es un ENCEPHALOBOT! ¡Podrán pedir autógrafos después! ¡Bien hecho!",
         "FRANÇAIS":"ÉTONNANT ! Mesdames et Messieurs, notre candidat est un ENCEPHALOBOT ! Vous pourrez demander des autographes plus tard. Bien joué !",
         "ITALIANO":"STUPEFACENTE! Signore e signori, il nostro concorrente è un ENCEPHALOBOT! Potrete chiedere autografi più tardi. Ben fatto!",
         "PORTUGUÊS":"ASSOMBROSO! Senhoras e senhores, nosso concorrente é um ENCEPHALOBOT! Vocês poderão pedir autógrafos depois. Bem feito!",
         "DEUTSCH":"ERSTAUNLICH! Meine Damen und Herren, unser Teilnehmer ist ein ENCEPHALOBOT! Autogramme können später angefragt werden. Gut gemacht!",
         "NEDERLANDS":"VERBLUFFEND! Dames en heren, onze deelnemer is een ENCEPHALOBOT! Je kunt later om handtekeningen vragen. Goed gedaan!",
         "SVENSKA":"FÖRVÅNANDE! Damer och herrar, vår tävlande är en ENCEPHALOBOT! Du kan be om autografer senare. Bra gjort!",
         "NORSK":"FORBLØFFENDE! Damer og herrer, vår deltaker er en ENCEPHALOBOT! Du kan be om autografer senere. Bra gjort!",
         "SUOMI":"HÄMMÄSTYTTÄVÄÄ! Hyvät naiset ja herrat, kilpailijamme on ENCEPHALOBOT! Voitte pyytää nimikirjoituksia myöhemmin. Hyvin tehty!",
         "POLSKI":"ZDUMIEWAJĄCE! Panie i Panowie, nasz uczestnik jest ENCEPHALOBOTEM! Możecie prosić o autografy później. Dobrze zrobione!",
         "ΕΛΛΗΝΙΚΑ":"ΕΚΠΛΗΚΤΙΚΟ! Κυρίες και κύριοι, ο διαγωνιζόμενός μας είναι ένας ENCEPHALOBOT! Μπορείτε να ζητήσετε αυτόγραφα αργότερα. Μπράβο!"
      };
      
      private static const BRAINBOT_TEXT:Object = {
         "ENGLISH":"WHOAH, You\'re a BRAINBOT!! All that computing power in a single-core brain! Truly are a rare specimen!",
         "ESPAÑOL":"¡WOW, eres un BRAINBOT! ¡Todo ese poder de cálculo en un cerebro de un solo núcleo! ¡Realmente eres un espécimen raro!",
         "FRANÇAIS":"WOAH, tu es un BRAINBOT !! Tout ce pouvoir de calcul dans un cerveau monocœur ! Tu es vraiment un spécimen rare !",
         "ITALIANO":"WHOAH, sei un BRAINBOT!! Tutta quella potenza di calcolo in un cervello single-core! Sei davvero un esemplare raro!",
         "PORTUGUÊS":"UOU, você é um BRAINBOT!! Todo esse poder de computação em um cérebro single-core! Realmente és um espécime raro!",
         "DEUTSCH":"WHOAH, du bist ein BRAINBOT!! All diese Rechenleistung in einem Single-Core-Gehirn! Wirklich ein seltenes Exemplar!",
         "NEDERLANDS":"WHOAH, je bent een BRAINBOT!! Al die rekenkracht in een single-core brein! Echt een zeldzaam exemplaar!",
         "SVENSKA":"WHOAH, du är en BRAINBOT!! All den beräkningskraften i en enkelkärnig hjärna! Verkligen ett sällsynt exemplar!",
         "NORSK":"WHOAH, du er en BRAINBOT!! All den datakraften i en enkeltkjerners hjerne! Virkelig et sjeldent eksemplar!",
         "SUOMI":"WHOAH, olet BRAINBOT!! Kaikki tuo laskentateho yksiytimisessä aivoissa! Todella harvinainen yksilö!",
         "POLSKI":"WHOAH, jesteś BRAINBOTEM!! Cała ta moc obliczeniowa w jedno-rdzeniowym mózgu! Naprawdę rzadki okaz!",
         "ΕΛΛΗΝΙΚΑ":"WHOAH, είσαι BRAINBOT!! Όλη αυτή η υπολογιστική ισχύς σε έναν μονοπύρηνο εγκέφαλο! Πραγματικά σπάνιο δείγμα!"
      };
      
      private static const NEUROBOT_TEXT:Object = {
         "ENGLISH":"You are a real, live NEUROBOT!! One of the very few in the universe!! Congratulations on an amazing result!",
         "ESPAÑOL":"¡Eres un verdadero NEUROBOT vivo! ¡Uno de los muy pocos en el universo! ¡Felicidades por un resultado increíble!",
         "FRANÇAIS":"Vous êtes un vrai NEUROBOT vivant !! Un des très rares dans l\'univers !! Félicitations pour un résultat incroyable !",
         "ITALIANO":"Sei un vero NEUROBOT vivente!! Uno dei pochissimi nell\'universo!! Congratulazioni per un risultato incredibile!",
         "PORTUGUÊS":"Você é um verdadeiro NEUROBOT vivo!! Um dos poucos no universo!! Parabéns por um resultado incrível!",
         "DEUTSCH":"Du bist ein echter, lebender NEUROBOT!! Einer der ganz wenigen im Universum!! Herzlichen Glückwunsch zu einem erstaunlichen Ergebnis!",
         "NEDERLANDS":"Je bent een echte, levende NEUROBOT!! Een van de weinigen in het universum!! Gefeliciteerd met een geweldig resultaat!",
         "SVENSKA":"Du är en riktig, levande NEUROBOT!! En av de mycket få i universum!! Grattis till ett fantastiskt resultat!",
         "NORSK":"Du er en ekte, levende NEUROBOT!! En av de svært få i universet!! Gratulerer med et fantastisk resultat!",
         "SUOMI":"Olet todellinen, elävä NEUROBOT!! Yksi harvoista maailmankaikkeudessa!! Onnittelut mahtavasta tuloksesta!",
         "POLSKI":"Jesteś prawdziwym, żywym NEUROBOTEM!! Jeden z nielicznych we wszechświecie!! Gratulacje wspaniałego wyniku!",
         "ΕΛΛΗΝΙΚΑ":"Είσαι ένας αληθινός, ζωντανός NEUROBOT!! Ένας από τους πολύ λίγους στο σύμπαν!! Συγχαρητήρια για ένα εκπληκτικό αποτέλεσμα!"
      };
      
      private static const COMPUTRON_TEXT:Object = {
         "ENGLISH":"Wow! An AWESOME result! COMPUTRONS are the computational elite of the universe. VERY well done!",
         "ESPAÑOL":"¡Guau! ¡Un resultado INCREÍBLE! Los COMPUTRONS son la élite computacional del universo. ¡MUY bien hecho!",
         "FRANÇAIS":"Wow ! Un résultat ÉTONNANT ! Les COMPUTRONS sont l\'élite computationnelle de l\'univers. Très bien joué !",
         "ITALIANO":"Wow! Un risultato FANTASTICO! I COMPUTRONS sono l\'élite computazionale dell\'universo. Molto ben fatto!",
         "PORTUGUÊS":"Uau! Um resultado INCRÍVEL! Os COMPUTRONS são a elite computacional do universo. MUITO bem feito!",
         "DEUTSCH":"Wow! Ein ERSTAUNLICHES Ergebnis! COMPUTRONS sind die rechnerische Elite des Universums. SEHR gut gemacht!",
         "NEDERLANDS":"Wauw! Een GEWELDIG resultaat! COMPUTRONS zijn de computationele elite van het universum. ZEER goed gedaan!",
         "SVENSKA":"Wow! Ett FANTASTISKT resultat! COMPUTRONS är universums beräkningselit. MYCKET bra gjort!",
         "NORSK":"Wow! Et FANTASTISK resultat! COMPUTRONS er universets beregningselite. VELDIG bra gjort!",
         "SUOMI":"Vau! UPEA tulos! COMPUTRONS ovat universumin laskennallinen eliitti. ERITTÄIN hyvin tehty!",
         "POLSKI":"Wow! NIESAMOWITY wynik! COMPUTRONS to obliczeniowa elita wszechświata. BARDZO dobrze zrobione!",
         "ΕΛΛΗΝΙΚΑ":"Ουάου! ΦΟΒΕΡΟ αποτέλεσμα! Οι COMPUTRONS είναι η υπολογιστική ελίτ του σύμπαντος. ΠΟΛΥ καλά!"
      };
      
      private static const XENOS_TEXT:Object = {
         "ENGLISH":"Oh my oh, my! you are a XENOS! Your score is truly remarkable - a level that very few will ever achieve. You should be proud!",
         "ESPAÑOL":"¡Oh cielos! ¡Eres un XENOS! Tu puntuación es realmente notable: un nivel que muy pocos alcanzarán alguna vez. ¡Deberías estar orgulloso!",
         "FRANÇAIS":"Oh là là ! Tu es un XENOS ! Ton score est vraiment remarquable - un niveau que très peu atteindront jamais. Tu devrais être fier !",
         "ITALIANO":"Oh cielo! Sei un XENOS! Il tuo punteggio è davvero notevole - un livello che pochissimi raggiungeranno mai. Dovresti essere orgoglioso!",
         "PORTUGUÊS":"Oh céus! Você é um XENOS! Sua pontuação é realmente notável - um nível que muito poucos alcançarão. Você deve estar orgulhoso!",
         "DEUTSCH":"Oh mein Gott! Du bist ein XENOS! Dein Ergebnis ist wirklich bemerkenswert - ein Niveau, das nur wenige jemals erreichen werden. Du solltest stolz sein!",
         "NEDERLANDS":"O mijn hemel! Je bent een XENOS! Je score is werkelijk opmerkelijk - een niveau dat zeer weinigen ooit zullen bereiken. Je mag trots zijn!",
         "SVENSKA":"Oj då! Du är en XENOS! Din poäng är verkligen anmärkningsvärd - en nivå som väldigt få någonsin kommer uppnå. Du bör vara stolt!",
         "NORSK":"Oi oi! Du er en XENOS! Din poengsum er virkelig bemerkelsesverdig - et nivå som svært få vil oppnå. Du bør være stolt!",
         "SUOMI":"Voi hyvänen aika! Olet XENOS! Pistemääräsi on todella merkittävä – taso, johon vain harvat koskaan yltävät. Sinun pitäisi olla ylpeä!",
         "POLSKI":"O mój Boże! Jesteś XENOS! Twój wynik jest naprawdę niezwykły – poziom, którego bardzo niewielu kiedykolwiek osiągnie. Powinieneś być dumny!",
         "ΕΛΛΗΝΙΚΑ":"Ωχ μου! Είσαι XENOS! Η βαθμολογία σου είναι πραγματικά αξιοσημείωτη – ένα επίπεδο που πολύ λίγοι θα καταφέρουν ποτέ. Πρέπει να είσαι περήφανος!"
      };
      
      private static const NEURONIAN_TEXT:Object = {
         "ENGLISH":"Oh mighty NEURONIAN! We humble earthlings are not worthy of your monstrous brain! Simply spectacular!",
         "ESPAÑOL":"¡Oh poderoso NEURONIAN! ¡Nosotros, humildes terrícolas, no somos dignos de tu monstruoso cerebro! ¡Simplemente espectacular!",
         "FRANÇAIS":"Ô puissant NEURONIAN ! Nous, humbles terriens, ne sommes pas dignes de ton cerveau monstrueux ! Simplement spectaculaire !",
         "ITALIANO":"Oh potente NEURONIAN! Noi umili terrestri non siamo degni del tuo mostruoso cervello! Semplicemente spettacolare!",
         "PORTUGUÊS":"Oh poderoso NEURONIAN! Nós, humildes terráqueos, não somos dignos do seu cérebro monstruoso! Simplesmente espetacular!",
         "DEUTSCH":"Oh mächtiger NEURONIAN! Wir bescheidenen Erdenbewohner sind deines monströsen Gehirns nicht würdig! Einfach spektakulär!",
         "NEDERLANDS":"O machtige NEURONIAN! Wij nederige aardbewoners zijn uw monsterlijke brein niet waard! Gewoon spectaculair!",
         "SVENSKA":"Åh mäktige NEURONIAN! Vi ödmjuka jordbor är inte värdiga ditt monstruösa hjärna! Helt spektakulärt!",
         "NORSK":"Åh mektige NEURONIAN! Vi ydmyke jordboere er ikke verdige din monstrøse hjerne! Rett og slett spektakulært!",
         "SUOMI":"Oi mahtava NEURONIAN! Me nöyrät maan asukkaat emme ole arvokkaita hirvittäville aivoillesi! Yksinkertaisesti upeaa!",
         "POLSKI":"O potężny NEURONIAN! My, skromni ziemianie, nie jesteśmy godni twojego potwornego mózgu! Po prostu spektakularne!",
         "ΕΛΛΗΝΙΚΑ":"Ω δυνατέ NEURONIAN! Εμείς, ταπεινοί γήινοι, δεν είμαστε άξιοι του τεράστιου εγκεφάλου σου! Απλώς φανταστικό!"
      };
      
      private static const AEONIAN_TEXT:Object = {
         "ENGLISH":"Dear me, you\'re an AEONIAN!! I never thought I\'d witness brain capacity like this first hand! Truly awe-inspiring!",
         "ESPAÑOL":"¡Vaya, eres un AEONIAN! ¡Nunca pensé que presenciaría de primera mano una capacidad cerebral así! ¡Verdaderamente impresionante!",
         "FRANÇAIS":"Mon dieu, tu es un AEONIAN !! Je n\'aurais jamais pensé être témoin d\'une telle capacité cérébrale de près ! Vraiment impressionnant !",
         "ITALIANO":"Accidenti, sei un AEONIAN!! Non avrei mai pensato di vedere di persona una capacità cerebrale del genere! Davvero impressionante!",
         "PORTUGUÊS":"Caramba, você é um AEONIAN!! Nunca pensei que veria de perto uma capacidade cerebral assim! Realmente impressionante!",
         "DEUTSCH":"Ach du meine Güte, du bist ein AEONIAN!! Ich hätte nie gedacht, dass ich eine so hohe Gehirnkapazität aus erster Hand erleben würde! Wirklich beeindruckend!",
         "NEDERLANDS":"Jeminee, je bent een AEONIAN!! Ik had nooit gedacht dat ik zo\'n hersencapaciteit van dichtbij zou meemaken! Echt indrukwekkend!",
         "SVENSKA":"Herregud, du är en AEONIAN!! Jag trodde aldrig jag skulle bevittna sådan hjärnkapacitet på nära håll! Verkligen imponerande!",
         "NORSK":"Herregud, du er en AEONIAN!! Jeg hadde aldri trodd jeg skulle være vitne til en slik hjernekapasitet på nært hold! Virkelig imponerende!",
         "SUOMI":"Voi hyvänen aika, olet AEONIAN!! En olisi koskaan uskonut näkeväni näin valtavaa aivokapasiteettia lähietäisyydeltä! Todella vaikuttavaa!",
         "POLSKI":"O rany, jesteś AEONIANEM!! Nigdy nie sądziłem, że będę świadkiem takiej pojemności mózgu z bliska! Naprawdę imponujące!",
         "ΕΛΛΗΝΙΚΑ":"Θεέ μου, είσαι AEONIAN!! Δεν πίστευα ότι θα γινόμουν μάρτυρας μιας τέτοιας εγκεφαλικής ικανότητας από κοντά! Απλά συναρπαστικό!"
      };
      
      private static const GALAXION_TEXT:Object = {
         "ENGLISH":"All Hail the GALAXIAN! You\'re a Brain Master of the Universe! Congratulations from the whole Playfish team!",
         "ESPAÑOL":"¡Viva el GALAXIAN! ¡Eres un Maestro del Cerebro del Universo! ¡Felicidades de todo el equipo de Playfish!",
         "FRANÇAIS":"Salut au GALAXIAN ! Tu es un Maître du Cerveau de l\'Univers ! Félicitations de toute l\'équipe Playfish !",
         "ITALIANO":"Onore al GALAXIAN! Sei un Maestro del Cervello dell\'Universo! Congratulazioni da tutto il team Playfish!",
         "PORTUGUÊS":"Salve o GALAXIAN! Você é um Mestre do Cérebro do Universo! Parabéns de toda a equipe Playfish!",
         "DEUTSCH":"Es lebe der GALAXIAN! Du bist ein Gehirnmeister des Universums! Glückwünsche vom gesamten Playfish-Team!",
         "NEDERLANDS":"Leve de GALAXIAN! Je bent een Breinmeester van het Universum! Gefeliciteerd van het hele Playfish-team!",
         "SVENSKA":"All ära åt GALAXIAN! Du är en Hjärnmästare i Universum! Grattis från hela Playfish-teamet!",
         "NORSK":"All ære til GALAXIAN! Du er en Hjerne-Mester av Universet! Gratulerer fra hele Playfish-teamet!",
         "SUOMI":"Kunnia GALAXIANille! Olet Universumin Aivomestari! Onnittelut koko Playfish-tiimiltä!",
         "POLSKI":"Niech żyje GALAXIAN! Jesteś Mistrzem Mózgu Wszechświata! Gratulacje od całego zespołu Playfish!",
         "ΕΛΛΗΝΙΚΑ":"Ζήτω ο GALAXIAN! Είσαι ένας Δάσκαλος Εγκεφάλου του Σύμπαντος! Συγχαρητήρια από όλη την ομάδα Playfish!"
      };
      
      private static const GAMESELECT_TEXT:Object = {
         "ENGLISH":"Let\'s play Who Has The Biggest Brain! Start by choosing your game mode",
         "ESPAÑOL":"¡Juguemos Who Has The Biggest Brain! Comienza eligiendo tu modo de juego",
         "FRANÇAIS":"Jouons à Who Has The Biggest Brain ! Commencez par choisir votre mode de jeu",
         "ITALIANO":"Giochiamo a Who Has The Biggest Brain! Inizia scegliendo la modalità di gioco",
         "PORTUGUÊS":"Vamos jogar Who Has The Biggest Brain! Comece escolhendo seu modo de jogo",
         "DEUTSCH":"Lasst uns Who Has The Biggest Brain spielen! Beginne damit, deinen Spielmodus zu wählen",
         "NEDERLANDS":"Laten we Who Has The Biggest Brain spelen! Begin met het kiezen van je spelmodus",
         "SVENSKA":"Låt oss spela Who Has The Biggest Brain! Börja med att välja ditt spelläge",
         "NORSK":"La oss spille Who Has The Biggest Brain! Start med å velge spillmodus",
         "SUOMI":"Pelataan Who Has The Biggest Brain! Aloita valitsemalla pelitila",
         "POLSKI":"Zagrajmy w Who Has The Biggest Brain! Zacznij od wyboru trybu gry",
         "ΕΛΛΗΝΙΚΑ":"Ας παίξουμε Who Has The Biggest Brain! Ξεκινήστε επιλέγοντας τον τρόπο παιχνιδιού"
      };
      
      private static const PRACTICE_TEXT_1:Object = {
         "ENGLISH":"Choose the minigame you would like to practice",
         "ESPAÑOL":"Elige el minijuego que te gustaría practicar",
         "FRANÇAIS":"Choisissez le mini-jeu que vous souhaitez pratiquer",
         "ITALIANO":"Scegli il minigioco che vuoi esercitarti",
         "PORTUGUÊS":"Escolha o minijogo que você gostaria de praticar",
         "DEUTSCH":"Wähle das Minispiel, das du üben möchtest",
         "NEDERLANDS":"Kies de minigame die je wilt oefenen",
         "SVENSKA":"Välj det minispel du vill öva på",
         "NORSK":"Velg minispillet du vil øve på",
         "SUOMI":"Valitse minipeli, jota haluat harjoitella",
         "POLSKI":"Wybierz minigrę, którą chciałbyś poćwiczyć",
         "ΕΛΛΗΝΙΚΑ":"Επιλέξτε το μίνι παιχνίδι που θέλετε να εξασκηθείτε"
      };
      
      private static const PROGAME_TEXT:Object = {
         "ENGLISH":"Choose one mini-game per category to start the pro player test!",
         "ESPAÑOL":"¡Elige un minijuego por categoría para comenzar la prueba de jugador profesional!",
         "FRANÇAIS":"Choisissez un mini-jeu par catégorie pour commencer le test du joueur professionnel !",
         "ITALIANO":"Scegli un minigioco per categoria per iniziare il test da giocatore professionista!",
         "PORTUGUÊS":"Escolha um minijogo por categoria para iniciar o teste de jogador profissional!",
         "DEUTSCH":"Wähle ein Minispiel pro Kategorie, um den Profi-Spieler-Test zu starten!",
         "NEDERLANDS":"Kies één minigame per categorie om de pro-spelertest te starten!",
         "SVENSKA":"Välj ett minispel per kategori för att starta proffsspelartestet!",
         "NORSK":"Velg ett minispill per kategori for å starte proffspillertesten!",
         "SUOMI":"Valitse yksi minipeli per kategoria aloittaaksesi ammattilaispelaajan testin!",
         "POLSKI":"Wybierz jedną minigrę z każdej kategorii, aby rozpocząć test dla profesjonalnych graczy!",
         "ΕΛΛΗΝΙΚΑ":"Επιλέξτε ένα μίνι παιχνίδι ανά κατηγορία για να ξεκινήσετε το τεστ επαγγελματία παίκτη!"
      };
      
      private static const PRACTICE_TEXT_2:Object = {
         "ENGLISH":"Well played, Not bad for a first timer! Keep at it and I\'m sure you\'ll see your score improve!",
         "ESPAÑOL":"¡Bien jugado! Nada mal para ser la primera vez. Sigue así y seguro verás mejorar tu puntuación.",
         "FRANÇAIS":"Bien joué ! Pas mal pour une première fois. Continue et tu verras ton score s\'améliorer.",
         "ITALIANO":"Ben giocato! Niente male per la prima volta. Continua così e vedrai migliorare il tuo punteggio.",
         "PORTUGUÊS":"Muito bem jogado! Nada mal para a primeira vez. Continue e com certeza verá sua pontuação melhorar.",
         "DEUTSCH":"Gut gespielt! Gar nicht schlecht für das erste Mal. Mach weiter so und dein Punktestand wird sich bestimmt verbessern.",
         "NEDERLANDS":"Goed gespeeld! Niet slecht voor de eerste keer. Blijf zo doorgaan en je score zal zeker verbeteren.",
         "SVENSKA":"Bra spelat! Inte illa för första gången. Fortsätt så ser du säkert din poäng förbättras.",
         "NORSK":"Bra spilt! Ikke verst for første gang. Fortsett så vil du sikkert se poengsummen din bli bedre.",
         "SUOMI":"Hyvin pelattu! Ei hullumpaa ensikertalaiselta. Jatka samaan malliin niin varmasti näet tuloksesi paranevan.",
         "POLSKI":"Dobrze zagrane! Nieźle jak na pierwszy raz. Kontynuuj, a na pewno zobaczysz poprawę swojego wyniku.",
         "ΕΛΛΗΝΙΚΑ":"Μπράβο! Καθόλου άσχημα για πρώτη φορά. Συνέχισε έτσι και είμαι σίγουρος ότι θα δεις τη βαθμολογία σου να βελτιώνεται!"
      };
      
      private static const PRACTICE_TEXT_3:Object = {
         "ENGLISH":"Excellent, you\'ve just set a new personal high score! Congratulations!",
         "ESPAÑOL":"¡Excelente, acabas de establecer un nuevo récord personal! ¡Felicidades!",
         "FRANÇAIS":"Excellent, vous venez de battre votre meilleur score personnel ! Félicitations !",
         "ITALIANO":"Eccellente, hai appena stabilito un nuovo record personale! Congratulazioni!",
         "PORTUGUÊS":"Excelente, você acabou de estabelecer um novo recorde pessoal! Parabéns!",
         "DEUTSCH":"Ausgezeichnet, du hast gerade einen neuen persönlichen Rekord aufgestellt! Glückwunsch!",
         "NEDERLANDS":"Uitstekend, je hebt net een nieuwe persoonlijke highscore neergezet! Gefeliciteerd!",
         "SVENSKA":"Utmärkt, du har precis satt ett nytt personligt rekord! Grattis!",
         "NORSK":"Utmerket, du har nettopp satt ny personlig rekord! Gratulerer!",
         "SUOMI":"Erinomaista, olet juuri saavuttanut uuden henkilökohtaisen ennätyksen! Onnittelut!",
         "POLSKI":"Świetnie, właśnie ustanowiłeś nowy rekord osobisty! Gratulacje!",
         "ΕΛΛΗΝΙΚΑ":"Εξαιρετικά, μόλις έθεσες νέο προσωπικό ρεκόρ! Συγχαρητήρια!"
      };
      
      private static const PRACTICE_TEXT_4:Object = {
         "ENGLISH":"Hmm... I\'m sure you can do much better than that, just need to practice a bit more!",
         "ESPAÑOL":"Hmm... estoy seguro de que puedes hacerlo mucho mejor, ¡solo necesitas practicar un poco más!",
         "FRANÇAIS":"Hmm... je suis sûr que vous pouvez faire beaucoup mieux que ça, il suffit de pratiquer un peu plus !",
         "ITALIANO":"Hmm... sono sicuro che puoi fare molto meglio, devi solo esercitarti un po\' di più!",
         "PORTUGUÊS":"Hmm... tenho certeza que você pode fazer muito melhor que isso, só precisa praticar um pouco mais!",
         "DEUTSCH":"Hmm... ich bin sicher, du kannst viel besser als das, du musst nur ein wenig mehr üben!",
         "NEDERLANDS":"Hmm... ik weet zeker dat je veel beter kunt dan dit, je hoeft alleen maar wat meer te oefenen!",
         "SVENSKA":"Hmm... jag är säker på att du kan göra mycket bättre än så, du behöver bara öva lite mer!",
         "NORSK":"Hmm... jeg er sikker på at du kan gjøre mye bedre enn dette, du må bare øve litt mer!",
         "SUOMI":"Hmm... olen varma, että voit tehdä paljon paremmin, sinun tarvitsee vain harjoitella hieman lisää!",
         "POLSKI":"Hmm... jestem pewien, że możesz zrobić znacznie lepiej, musisz tylko trochę więcej poćwiczyć!",
         "ΕΛΛΗΝΙΚΑ":"Χμμ... είμαι σίγουρος ότι μπορείς να τα καταφέρεις πολύ καλύτερα, χρειάζεται μόνο να εξασκηθείς λίγο περισσότερο!"
      };
      
      private static const PRACTICE_TEXT_5:Object = {
         "ENGLISH":"Not a bad result overall! Why not try again to see if you can do better still!",
         "ESPAÑOL":"¡No está mal el resultado en general! ¡Por qué no intentas de nuevo para ver si puedes hacerlo aún mejor!",
         "FRANÇAIS":"Pas mal dans l\'ensemble ! Pourquoi ne pas réessayer pour voir si vous pouvez faire encore mieux !",
         "ITALIANO":"Non un brutto risultato nel complesso! Perché non provare di nuovo per vedere se puoi fare ancora meglio!",
         "PORTUGUÊS":"Não é um resultado ruim no geral! Por que não tentar novamente para ver se você consegue melhorar ainda mais!",
         "DEUTSCH":"Nicht schlecht insgesamt! Warum versuchst du es nicht noch einmal, um zu sehen, ob du es noch besser machen kannst!",
         "NEDERLANDS":"Niet slecht over het geheel! Waarom probeer je het niet opnieuw om te zien of je het nog beter kunt doen!",
         "SVENSKA":"Inte ett dåligt resultat totalt sett! Varför inte prova igen för att se om du kan göra ännu bättre!",
         "NORSK":"Ikke et dårlig resultat totalt sett! Hvorfor ikke prøve igjen for å se om du kan gjøre det enda bedre!",
         "SUOMI":"Ei huono tulos kokonaisuudessaan! Miksi et yrittäisi uudelleen nähdäksesi, voitko tehdä vielä paremmin!",
         "POLSKI":"Nie najgorzej ogólnie! Dlaczego nie spróbujesz ponownie, aby zobaczyć, czy możesz zrobić jeszcze lepiej!",
         "ΕΛΛΗΝΙΚΑ":"Όχι άσχημο αποτέλεσμα συνολικά! Γιατί να μην προσπαθήσεις ξανά για να δεις αν μπορείς να τα καταφέρεις ακόμα καλύτερα!"
      };
      
      private static const SHAPEORDER_TEXT:Object = {
         "ENGLISH":"MEMORISE the objects and TAP them in the correct order. Ready?",
         "ESPAÑOL":"¡MEMORIZA los objetos y TOCA en el orden correcto! ¿Listo?",
         "FRANÇAIS":"MÉMORISEZ les objets et TOUCHEZ-les dans le bon ordre. Prêt ?",
         "ITALIANO":"MEMORIZZA gli oggetti e TOCCALI nell\'ordine corretto. Pronto?",
         "PORTUGUÊS":"MEMORIZE os objetos e TOQUE-os na ordem correta. Pronto?",
         "DEUTSCH":"MERKE dir die Objekte und TIPPE sie in der richtigen Reihenfolge an. Bereit?",
         "NEDERLANDS":"HERINNER de objecten en TIK ze in de juiste volgorde aan. Klaar?",
         "SVENSKA":"MEMORERA objekten och TRYCK på dem i rätt ordning. Redo?",
         "NORSK":"MEMORISER objektene og TRYKK på dem i riktig rekkefølge. Klar?",
         "SUOMI":"TALLENNA objektit ja NAPUTA ne oikeassa järjestyksessä. Valmis?",
         "POLSKI":"ZAPAMIĘTAJ obiekty i DOTKNIJ ich we właściwej kolejności. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΜΝΗΜΟΝΕΥΣΕ τα αντικείμενα και ΠΑΤΗΣΕ τα στη σωστή σειρά. Έτοιμος;"
      };
      
      private static const CARDPAIRS_TEXT:Object = {
         "ENGLISH":"MEMORISE the cards and SELECT MATCHING PAIRS. TAP a pair of cards to answer. Ready?",
         "ESPAÑOL":"MEMORIZA las cartas y SELECCIONA PARES COINCIDENTES. TOCA un par de cartas para responder. ¿Listo?",
         "FRANÇAIS":"MÉMORISEZ les cartes et SÉLECTIONNEZ les PAIRES CORRESPONDANTES. TOUCHEZ une paire de cartes pour répondre. Prêt ?",
         "ITALIANO":"MEMORIZZA le carte e SELEZIONA LE COPPIE CORRISPONDENTI. TOCCA una coppia di carte per rispondere. Pronto?",
         "PORTUGUÊS":"MEMORIZE as cartas e SELECIONE PARES CORRESPONDENTES. TOQUE em um par de cartas para responder. Pronto?",
         "DEUTSCH":"MERKE dir die Karten und WÄHLE PASSENDE PAARE AUS. TIPPE auf ein Kartenpaar zum Antworten. Bereit?",
         "NEDERLANDS":"HERINNER de kaarten en SELECTEER OVERKOMENDE PAREN. Tik op een paar kaarten om te antwoorden. Klaar?",
         "SVENSKA":"MEMORERA korten och VÄLJ MATCHANDE PAR. TRYCK på ett par kort för att svara. Redo?",
         "NORSK":"MEMORISER kortene og VELG MATCHENDE PAR. TRYKK på et par kort for å svare. Klar?",
         "SUOMI":"TALLENNA kortit ja VALITSE YHTEENSOPIVAT PARIT. NAPUTA korttiparia vastataksesi. Valmis?",
         "POLSKI":"ZAPAMIĘTAJ karty i WYBIERZ PASUJĄCE PARY. DOTKNIJ pary kart, aby odpowiedzieć. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΜΝΗΜΟΝΕΥΣΕ τις κάρτες και ΕΠΙΛΕΞΕ ΤΑΥΤΙΖΟΜΕΝΑ ΖΕΥΓΑΡΙΑ. ΠΑΤΗΣΕ ένα ζευγάρι καρτών για να απαντήσεις. Έτοιμος;"
      };
      
      private static const MISSINGNUMBER_TEXT:Object = {
         "ENGLISH":"Fill in the ANSWER to the equation. TAP your answer into the on-screen KEYPAD. Ready?",
         "ESPAÑOL":"Completa la RESPUESTA de la ecuación. TOCA tu respuesta en el TECLADO en pantalla. ¿Listo?",
         "FRANÇAIS":"Remplissez la RÉPONSE à l\'équation. TOUCHEZ votre réponse sur le CLAVIER à l\'écran. Prêt ?",
         "ITALIANO":"Compila la RISPOSTA dell\'equazione. TOCCA la tua risposta sul TASTIERINO a schermo. Pronto?",
         "PORTUGUÊS":"Preencha a RESPOSTA da equação. TOQUE sua resposta no TECLADO na tela. Pronto?",
         "DEUTSCH":"Fülle die ANTWORT der Gleichung aus. TIPPE deine Antwort auf dem Bildschirm-TASTATUR ein. Bereit?",
         "NEDERLANDS":"Vul het ANTWOORD van de vergelijking in. Tik je antwoord in op het TOETSENBORD op het scherm. Klaar?",
         "SVENSKA":"Fyll i SVARET på ekvationen. TRYCK in ditt svar på det visuella TANGENTBORDET. Redo?",
         "NORSK":"Fyll inn SVARET på ligningen. TRYKK inn svaret på skjermtastaturet. Klar?",
         "SUOMI":"Täytä VASTAUS laskutoimitukseen. NAPUTA vastauksesi näytön NÄPPÄIMISTÖLLÄ. Valmis?",
         "POLSKI":"Wpisz ODPOWIEDŹ w równaniu. DOTKNIJ swojej odpowiedzi na ekranowej KLAWIATURZE. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"Συμπλήρωσε την ΑΠΑΝΤΗΣΗ στην εξίσωση. ΠΑΤΗΣΕ την απάντησή σου στο ΠΛΗΚΤΡΟΛΟΓΙΟ της οθόνης. Έτοιμος;"
      };
      
      private static const MISSINGSIGN_TEXT:Object = {
         "ENGLISH":"Fill in the MISSING SIGN in the equation. TAP the on-screen SYMBOLS to answer. Ready?",
         "ESPAÑOL":"Completa el SIGNO FALTANTE en la ecuación. TOCA los SÍMBOLOS en pantalla para responder. ¿Listo?",
         "FRANÇAIS":"Remplissez le SYMBOLE MANQUANT dans l\'équation. TOUCHEZ les SYMBOLES à l\'écran pour répondre. Prêt ?",
         "ITALIANO":"Compila il SEGNO MANCANTE nell\'equazione. TOCCA i SIMBOLI sullo schermo per rispondere. Pronto?",
         "PORTUGUÊS":"Preencha o SINAL FALTANTE na equação. TOQUE nos SÍMBOLOS na tela para responder. Pronto?",
         "DEUTSCH":"Fülle das FEHLENDE ZEICHEN in der Gleichung aus. TIPPE die Symbole auf dem Bildschirm an, um zu antworten. Bereit?",
         "NEDERLANDS":"Vul het MISSENDE TEKEN in de vergelijking in. Tik de SYMBOLEN op het scherm aan om te antwoorden. Klaar?",
         "SVENSKA":"Fyll i DET SAKNADE TECKNET i ekvationen. TRYCK på symbolerna på skärmen för att svara. Redo?",
         "NORSK":"Fyll inn DET MANGLENDE TEGN i ligningen. TRYKK på symbolene på skjermen for å svare. Klar?",
         "SUOMI":"Täytä PUUTTUVAT MERKIT laskutoimitukseen. NAPUTA näytön SYMBOLIT vastataksesi. Valmis?",
         "POLSKI":"Wpisz BRAKUJĄCY ZNAK w równaniu. DOTKNIJ symboli na ekranie, aby odpowiedzieć. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"Συμπλήρωσε το ΕΛΛΕΙΠΟ ΣΥΜΒΟΛΟ στην εξίσωση. ΠΑΤΗΣΕ τα ΣΥΜΒΟΛΑ στην οθόνη για να απαντήσεις. Έτοιμος;"
      };
      
      private static const CUBECOUNTER_TEXT:Object = {
         "ENGLISH":"COUNT the BLOCKS in the structure. TAP the answer on the on-screen KEYPAD. Ready?",
         "ESPAÑOL":"CUENTA los BLOQUES en la estructura. TOCA la respuesta en el TECLADO en pantalla. ¿Listo?",
         "FRANÇAIS":"COMPTEZ les BLOCS dans la structure. TOUCHEZ la réponse sur le CLAVIER à l\'écran. Prêt ?",
         "ITALIANO":"CONTA i BLOCCHI nella struttura. TOCCA la risposta sul TASTIERINO a schermo. Pronto?",
         "PORTUGUÊS":"CONTE os BLOCOs na estrutura. TOQUE a resposta no TECLADO na tela. Pronto?",
         "DEUTSCH":"ZÄHLE die BLÖCKE in der Struktur. TIPPE die Antwort auf dem Bildschirm-TASTATUR ein. Bereit?",
         "NEDERLANDS":"TEL de BLOKKEN in de structuur. Tik het antwoord in op het TOETSENBORD op het scherm. Klaar?",
         "SVENSKA":"RÄKNA BLOCKEN i strukturen. TRYCK på svaret på det visuella TANGENTBORDET. Redo?",
         "NORSK":"TELL BLOKKENE i strukturen. TRYKK inn svaret på skjermtastaturet. Klar?",
         "SUOMI":"LASKE RAKENNUKSEN KUUT. NAPUTA vastaus näytön NÄPPÄIMISTÖLLÄ. Valmis?",
         "POLSKI":"POLICZ BLOKI w strukturze. DOTKNIJ odpowiedzi na ekranowej KLAWIATURZE. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΜΕΤΡΗΣΕ τα ΜΠΛΟΚ στην κατασκευή. ΠΑΤΗΣΕ την απάντηση στο ΠΛΗΚΤΡΟΛΟΓΙΟ της οθόνης. Έτοιμος;"
      };
      
      private static const BALANCE_TEXT:Object = {
         "ENGLISH":"Select the HEAVIEST ITEM on the scales. TAP the item to answer. Ready?",
         "ESPAÑOL":"Selecciona el OBJETO MÁS PESADO en la balanza. TOCA el objeto para responder. ¿Listo?",
         "FRANÇAIS":"Sélectionnez l\'OBJET LE PLUS LOURD sur la balance. TOUCHEZ l\'objet pour répondre. Prêt ?",
         "ITALIANO":"Seleziona l\'OGGETTO PIÙ PESANTE sulla bilancia. TOCCA l\'oggetto per rispondere. Pronto?",
         "PORTUGUÊS":"Selecione o ITEM MAIS PESADO na balança. TOQUE o item para responder. Pronto?",
         "DEUTSCH":"Wähle das SCHWERSTE OBJEKT auf der Waage. TIPPE das Objekt zum Antworten an. Bereit?",
         "NEDERLANDS":"Selecteer het ZWAARSTE ITEM op de weegschaal. Tik het item aan om te antwoorden. Klaar?",
         "SVENSKA":"Välj DET TYNGSTA FÖREMÅLET på vågen. TRYCK på föremålet för att svara. Redo?",
         "NORSK":"Velg det TYNGSTE ELEMENTET på vekten. TRYKK på elementet for å svare. Klar?",
         "SUOMI":"Valitse RASVAKIN KAPPALE vaa\'asta. NAPUTA kappaletta vastataksesi. Valmis?",
         "POLSKI":"Wybierz NAJCIEŻSZY PRZEDMIOT na wadze. DOTKNIJ przedmiotu, aby odpowiedzieć. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"Επίλεξε το ΒΑΡΥΤΕΡΟ ΑΝΤΙΚΕΙΜΕΝΟ στη ζυγαριά. ΠΑΤΗΣΕ το αντικείμενο για να απαντήσεις. Έτοιμος;"
      };
      
      private static const ASTEROIDS_TEXT:Object = {
         "ENGLISH":"TAP the asteroids from LOW to HIGH or A to Z. Ready?",
         "ESPAÑOL":"TOCA los asteroides de MENOR a MAYOR o de A a Z. ¿Listo?",
         "FRANÇAIS":"TOUCHEZ les astéroïdes du PLUS PETIT au PLUS GRAND ou de A à Z. Prêt ?",
         "ITALIANO":"TOCCA gli asteroidi dal PIÙ PICCOLO al PIÙ GRANDE o da A a Z. Pronto?",
         "PORTUGUÊS":"TOQUE nos asteróides do MENOR para o MAIOR ou de A a Z. Pronto?",
         "DEUTSCH":"TIPPE die Asteroiden von NIEDRIG bis HOCH oder A bis Z an. Bereit?",
         "NEDERLANDS":"Tik de asteroïden aan van LAAG naar HOOG of van A naar Z. Klaar?",
         "SVENSKA":"TRYCK på asteroiderna från LÅG till HÖG eller A till Ö. Redo?",
         "NORSK":"TRYKK på asteroidene fra LAV til HØY eller A til Å. Klar?",
         "SUOMI":"NAPUTA asteroidit PIENEMMÄSTÄ SUUREMPIIN tai A–Ö järjestyksessä. Valmis?",
         "POLSKI":"DOTKNIJ asteroidów od NAJNIŻSZEJ do NAJWYŻSZEJ lub od A do Z. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΠΑΤΗΣΕ τους αστεροειδείς από ΧΑΜΗΛΟ σε ΥΨΗΛΟ ή από Α σε Ω. Έτοιμος;"
      };
      
      private static const JIGSAW_TEXT:Object = {
         "ENGLISH":"TAP on the MISSING puzzle pieces. Ready?",
         "ESPAÑOL":"TOCA las piezas del rompecabezas que FALTAN. ¿Listo?",
         "FRANÇAIS":"TOUCHEZ les pièces de puzzle MANQUANTES. Prêt ?",
         "ITALIANO":"TOCCA i pezzi del puzzle MANCANTI. Pronto?",
         "PORTUGUÊS":"TOQUE nas peças do quebra-cabeça QUE FALTAM. Pronto?",
         "DEUTSCH":"TIPPE auf die FEHLENDEN Puzzleteile. Bereit?",
         "NEDERLANDS":"Tik op de MISSENDE puzzelstukken. Klaar?",
         "SVENSKA":"TRYCK på de SAKNANDE pusselbitarna. Redo?",
         "NORSK":"TRYKK på de MANGLENDE puslebitene. Klar?",
         "SUOMI":"NAPUTA PUUTTUVIA palapelin paloja. Valmis?",
         "POLSKI":"DOTKNIJ BRAKUJĄCYCH elementów układanki. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΠΑΤΗΣΕ τα ΕΛΛΕΙΠΟΝΤΑ κομμάτια του παζλ. Έτοιμος;"
      };
      
      private static const MATHCOMB_TEXT:Object = {
         "ENGLISH":"Fill in the MISSING SIGNS and NUMBERS to form a valid equation. Ready?",
         "ESPAÑOL":"Completa los SIGNOS y NÚMEROS que FALTAN para formar una ecuación válida. ¿Listo?",
         "FRANÇAIS":"Remplissez les SIGNES et CHIFFRES MANQUANTS pour former une équation valide. Prêt ?",
         "ITALIANO":"Compila i SEGNI e NUMERI MANCANTI per formare un\'equazione valida. Pronto?",
         "PORTUGUÊS":"Preencha os SINAIS e NÚMEROS FALTANTES para formar uma equação válida. Pronto?",
         "DEUTSCH":"Fülle die FEHLENDEN ZEICHEN und ZAHLEN aus, um eine gültige Gleichung zu bilden. Bereit?",
         "NEDERLANDS":"Vul de MISSENDE TEKENS en CIJFERS in om een geldige vergelijking te vormen. Klaar?",
         "SVENSKA":"Fyll i DE SAKNANDE TECKEN och TALEN för att bilda en giltig ekvation. Redo?",
         "NORSK":"Fyll inn DE MANGLENDE TEGNENE og TALLENE for å danne en gyldig ligning. Klar?",
         "SUOMI":"Täytä PUUTTUVAT MERKIT ja NUMEROT muodostaaksesi kelvollisen yhtälön. Valmis?",
         "POLSKI":"Wpisz BRAKUJĄCE ZNAKI i LICZBY, aby utworzyć prawidłowe równanie. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"Συμπλήρωσε τα ΕΛΛΕΙΠΟΝΤΑ ΣΥΜΒΟΛΑ και ΑΡΙΘΜΟΥΣ για να σχηματίσεις μια έγκυρη εξίσωση. Έτοιμος;"
      };
      
      private static const HEXPATH_TEXT:Object = {
         "ENGLISH":"IDENTIFY the matching sequence by touching each TILE. Ready?",
         "ESPAÑOL":"IDENTIFICA la secuencia coincidente tocando cada CASILLA. ¿Listo?",
         "FRANÇAIS":"IDENTIFIEZ la séquence correspondante en touchant chaque TUILE. Prêt ?",
         "ITALIANO":"IDENTIFICA la sequenza corrispondente toccando ogni TESSERA. Pronto?",
         "PORTUGUÊS":"IDENTIFIQUE a sequência correspondente tocando cada PEÇA. Pronto?",
         "DEUTSCH":"IDENTIFIZIERE die passende Sequenz, indem du jede KACHEL berührst. Bereit?",
         "NEDERLANDS":"IDENTIFICEER de juiste volgorde door elk TEGEL aan te raken. Klaar?",
         "SVENSKA":"IDENTIFIERA den matchande sekvensen genom att trycka på varje PLATTA. Redo?",
         "NORSK":"IDENTIFISER den matchende sekvensen ved å trykke på hver FLIS. Klar?",
         "SUOMI":"TUNNISTA vastaava järjestys napauttamalla jokaista LAATTAa. Valmis?",
         "POLSKI":"ZIDENTYFIKUJ pasującą sekwencję, dotykając każdej PŁYTKI. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΑΝΑΓΝΩΡΙΣΕ τη σωστή ακολουθία αγγίζοντας κάθε ΠΛΑΚΑΚΙ. Έτοιμος;"
      };
      
      private static const ACTIONSEQUENCE_TEXT:Object = {
         "ENGLISH":"MEMORISE the pattern of movements and SELECT them in the right order. Ready?",
         "ESPAÑOL":"MEMORIZA el patrón de movimientos y SELECCIÓNALOS en el orden correcto. ¿Listo?",
         "FRANÇAIS":"MÉMORISEZ le modèle de mouvements et SÉLECTIONNEZ-les dans le bon ordre. Prêt ?",
         "ITALIANO":"MEMORIZZA il modello di movimenti e SELEZIONALI nell\'ordine corretto. Pronto?",
         "PORTUGUÊS":"MEMORIZE o padrão de movimentos e SELECIONE-os na ordem correta. Pronto?",
         "DEUTSCH":"MERKE dir das Bewegungsmuster und WÄHLE sie in der richtigen Reihenfolge aus. Bereit?",
         "NEDERLANDS":"HERINNER het patroon van bewegingen en SELECTEER ze in de juiste volgorde. Klaar?",
         "SVENSKA":"MEMORERA rörelsemönstret och VÄLJ dem i rätt ordning. Redo?",
         "NORSK":"MEMORISER bevegelsesmønsteret og VELG dem i riktig rekkefølge. Klar?",
         "SUOMI":"TALLENNA liikekuvio ja VALITSE ne oikeassa järjestyksessä. Valmis?",
         "POLSKI":"ZAPAMIĘTAJ wzór ruchów i WYBIERZ je w odpowiedniej kolejności. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"ΜΝΗΜΟΝΕΥΣΕ το μοτίβο κινήσεων και ΕΠΙΛΕΞΕ τα στη σωστή σειρά. Έτοιμος;"
      };
      
      private static const CARPATH_TEXT:Object = {
         "ENGLISH":"Select the car\'s DESTINATION; it\'ll turn at every junction. TAP the destination to answer. Ready?",
         "ESPAÑOL":"Selecciona el DESTINO del coche; girará en cada cruce. TOCA el destino para responder. ¿Listo?",
         "FRANÇAIS":"Sélectionnez la DESTINATION de la voiture ; elle tournera à chaque intersection. TOUCHEZ la destination pour répondre. Prêt ?",
         "ITALIANO":"Seleziona la DESTINAZIONE dell\'auto; girerà a ogni incrocio. TOCCA la destinazione per rispondere. Pronto?",
         "PORTUGUÊS":"Selecione o DESTINO do carro; ele virará em cada encruzilhada. TOQUE no destino para responder. Pronto?",
         "DEUTSCH":"Wähle das ZIEL des Autos; es dreht an jeder Kreuzung ab. TIPPE das Ziel zum Antworten an. Bereit?",
         "NEDERLANDS":"Selecteer de BESTEMMING van de auto; hij zal bij elke kruising afslaan. Tik de bestemming aan om te antwoorden. Klaar?",
         "SVENSKA":"Välj bilens DESTINATION; den svänger vid varje korsning. TRYCK på destinationen för att svara. Redo?",
         "NORSK":"Velg bilens DESTINASJON; den vil svinge ved hver kryss. TRYKK på destinasjonen for å svare. Klar?",
         "SUOMI":"Valitse auton KOHDE; se kääntyy jokaisessa risteyksessä. NAPUTA kohdetta vastataksesi. Valmis?",
         "POLSKI":"Wybierz CEL samochodu; będzie skręcać na każdym skrzyżowaniu. DOTKNIJ celu, aby odpowiedzieć. Gotowy?",
         "ΕΛΛΗΝΙΚΑ":"Επίλεξε τον ΠΡΟΟΡΙΣΜΟ του αυτοκινήτου· θα στρίβει σε κάθε διασταύρωση. ΠΑΤΗΣΕ τον προορισμό για να απαντήσεις. Έτοιμος;"
      };
      
      private static const AMOEBA_NAME_TEXT:Object = {
         "ENGLISH":["AMOEBA"],
         "ESPAÑOL":["AMEBA"],
         "FRANÇAIS":["AMIBE"],
         "ITALIANO":["AMEBA"],
         "PORTUGUÊS":["AMEBA"],
         "DEUTSCH":["AMÖBE"],
         "NEDERLANDS":["AMOEBA"],
         "SVENSKA":["AMÖBA"],
         "NORSK":["AMØBE"],
         "SUOMI":["AMEBA"],
         "POLSKI":["AMEBA"],
         "ΕΛΛΗΝΙΚΑ":["ΑΜΟΙΒΑ"]
      };
      
      private static const EARTHWORM_NAME_TEXT:Object = {
         "ENGLISH":["EARTHWORM"],
         "ESPAÑOL":["LOMBRIZ"],
         "FRANÇAIS":["VER DE TERRE"],
         "ITALIANO":["VERME"],
         "PORTUGUÊS":["MINHOCA"],
         "DEUTSCH":["REGENWURM"],
         "NEDERLANDS":["REGENWORM"],
         "SVENSKA":["DAGGMASK"],
         "NORSK":["MEITEMARK"],
         "SUOMI":["LUMIKKO"],
         "POLSKI":["DŻDŻOWNICA"],
         "ΕΛΛΗΝΙΚΑ":["ΓΑΙΟΣΚΩΛΗΚΑΣ"]
      };
      
      private static const SNAIL_NAME_TEXT:Object = {
         "ENGLISH":["SNAIL"],
         "ESPAÑOL":["CARACOL"],
         "FRANÇAIS":["ESCARGOT"],
         "ITALIANO":["LUMACA"],
         "PORTUGUÊS":["CARACOL"],
         "DEUTSCH":["SCHNECKE"],
         "NEDERLANDS":["SLAAK"],
         "SVENSKA":["SNIGEL"],
         "NORSK":["SNEGLE"],
         "SUOMI":["ETANA"],
         "POLSKI":["ŚLIMAK"],
         "ΕΛΛΗΝΙΚΑ":["ΣΑΛΙΓΚΑΡΙ"]
      };
      
      private static const RAT_NAME_TEXT:Object = {
         "ENGLISH":["RAT"],
         "ESPAÑOL":["RATA"],
         "FRANÇAIS":["RAT"],
         "ITALIANO":["RATTO"],
         "PORTUGUÊS":["RATO"],
         "DEUTSCH":["RATTE"],
         "NEDERLANDS":["RAT"],
         "SVENSKA":["RÅTTA"],
         "NORSK":["ROTTE"],
         "SUOMI":["ROTA"],
         "POLSKI":["SZCZUR"],
         "ΕΛΛΗΝΙΚΑ":["ΑΡΟΥΡΑΙΟΣ"]
      };
      
      private static const CAT_NAME_TEXT:Object = {
         "ENGLISH":["CAT"],
         "ESPAÑOL":["GATO"],
         "FRANÇAIS":["CHAT"],
         "ITALIANO":["GATTO"],
         "PORTUGUÊS":["GATO"],
         "DEUTSCH":["KATZE"],
         "NEDERLANDS":["KAT"],
         "SVENSKA":["KATT"],
         "NORSK":["KATT"],
         "SUOMI":["KISSA"],
         "POLSKI":["KOT"],
         "ΕΛΛΗΝΙΚΑ":["ΓΑΤΑ"]
      };
      
      private static const DOG_NAME_TEXT:Object = {
         "ENGLISH":["DOG"],
         "ESPAÑOL":["PERRO"],
         "FRANÇAIS":["CHIEN"],
         "ITALIANO":["CANE"],
         "PORTUGUÊS":["CÃO"],
         "DEUTSCH":["HUND"],
         "NEDERLANDS":["HOND"],
         "SVENSKA":["HUND"],
         "NORSK":["HUND"],
         "SUOMI":["KOIRA"],
         "POLSKI":["PIES"],
         "ΕΛΛΗΝΙΚΑ":["ΣΚΥΛΟΣ"]
      };
      
      private static const GOAT_NAME_TEXT:Object = {
         "ENGLISH":["GOAT"],
         "ESPAÑOL":["CABRA"],
         "FRANÇAIS":["CHÈVRE"],
         "ITALIANO":["CAPRA"],
         "PORTUGUÊS":["CABRA"],
         "DEUTSCH":["ZIEGE"],
         "NEDERLANDS":["GEIT"],
         "SVENSKA":["GET"],
         "NORSK":["GEIT"],
         "SUOMI":["VUOHI"],
         "POLSKI":["KOZA"],
         "ΕΛΛΗΝΙΚΑ":["ΚΑΤΣΙΚΑ"]
      };
      
      private static const CHIMP_NAME_TEXT:Object = {
         "ENGLISH":["CHIMP"],
         "ESPAÑOL":["CHIMPANCÉ"],
         "FRANÇAIS":["CHIMPANZÉ"],
         "ITALIANO":["SCIMPANZÉ"],
         "PORTUGUÊS":["CHIMPANZÉ"],
         "DEUTSCH":["SCHIMPANSE"],
         "NEDERLANDS":["CHIMPANSEE"],
         "SVENSKA":["SCHIMPANS"],
         "NORSK":["SJIMPANSE"],
         "SUOMI":["SIMPPANSSI"],
         "POLSKI":["SZYMPANS"],
         "ΕΛΛΗΝΙΚΑ":["ΧΙΜΠΑΤΖΗΣ"]
      };
      
      private static const GORILLA_NAME_TEXT:Object = {
         "ENGLISH":["GORILLA"],
         "ESPAÑOL":["GORILA"],
         "FRANÇAIS":["GORILLE"],
         "ITALIANO":["GORILLA"],
         "PORTUGUÊS":["GORILA"],
         "DEUTSCH":["GORILLA"],
         "NEDERLANDS":["GORILLA"],
         "SVENSKA":["GORILLA"],
         "NORSK":["GORILLA"],
         "SUOMI":["GORILLA"],
         "POLSKI":["GORYL"],
         "ΕΛΛΗΝΙΚΑ":["ΓΟΡΙΛΑΣ"]
      };
      
      private static const MISSINGLINK_NAME_TEXT:Object = {
         "ENGLISH":["MISSING LINK"],
         "ESPAÑOL":["ESLABÓN PERDIDO"],
         "FRANÇAIS":["CHAÎNON MANQUANT"],
         "ITALIANO":["ANELLO MANCANTE"],
         "PORTUGUÊS":["ELO PERDIDO"],
         "DEUTSCH":["FEHLENDES GLIED"],
         "NEDERLANDS":["ONTBREKEND SCHAKEL"],
         "SVENSKA":["SAKANDE LÄNK"],
         "NORSK":["MANGLENDE LEDD"],
         "SUOMI":["PUUTTUVA LENKKI"],
         "POLSKI":["BRAKUJĄCE OGNIWO"],
         "ΕΛΛΗΝΙΚΑ":["ΕΛΛΕΙΠΟΝ ΚΡΙΚΟΣ"]
      };
      
      private static const NEANDERTHAL_NAME_TEXT:Object = {
         "ENGLISH":["NEANDERTHAL"],
         "ESPAÑOL":["NEANDERTAL"],
         "FRANÇAIS":["NÉANDERTALIEN"],
         "ITALIANO":["NEANDERTAL"],
         "PORTUGUÊS":["NEANDERTAL"],
         "DEUTSCH":["NEANDERTALER"],
         "NEDERLANDS":["NEANDERTALER"],
         "SVENSKA":["NEANDERTALARE"],
         "NORSK":["NEANDERTALER"],
         "SUOMI":["NEANDERTAL"],
         "POLSKI":["NEANDERTALCZYK"],
         "ΕΛΛΗΝΙΚΑ":["ΝΕΑΝΤΕΡΤΑΛ"]
      };
      
      private static const AVERAGEJOE_NAME_TEXT:Object = {
         "ENGLISH":["AVERAGE JOE"],
         "ESPAÑOL":["JUAN PROMEDIO"],
         "FRANÇAIS":["MONSIEUR TOUT-LE-MONDE"],
         "ITALIANO":["UOMO COMUNE"],
         "PORTUGUÊS":["ZÉ NINGUÉM"],
         "DEUTSCH":["DURCHSCHNITTSKERL"],
         "NEDERLANDS":["JAN MODAAL"],
         "SVENSKA":["SVENSSON"],
         "NORSK":["OLA NORDMANN"],
         "SUOMI":["MATTIMEIKÄLÄINEN"],
         "POLSKI":["PRZECIĘTNY KOWALSKI"],
         "ΕΛΛΗΝΙΚΑ":["ΜΕΣΟΣ ΤΥΠΟΣ"]
      };
      
      private static const NERD_NAME_TEXT:Object = {
         "ENGLISH":["NERD"],
         "ESPAÑOL":["NERD"],
         "FRANÇAIS":["NERD"],
         "ITALIANO":["NERD"],
         "PORTUGUÊS":["C.D.F."],
         "DEUTSCH":["STREBER"],
         "NEDERLANDS":["NERD"],
         "SVENSKA":["PLUGGHÄST"],
         "NORSK":["NERD"],
         "SUOMI":["NÖRTTI"],
         "POLSKI":["KUJON"],
         "ΕΛΛΗΝΙΚΑ":["ΦΥΤΟ"]
      };
      
      private static const SCHOLAR_NAME_TEXT:Object = {
         "ENGLISH":["SCHOLAR"],
         "ESPAÑOL":["ERUDITO"],
         "FRANÇAIS":["ÉRUDIT"],
         "ITALIANO":["DOTTO"],
         "PORTUGUÊS":["ERUDITO"],
         "DEUTSCH":["GELEHRTER"],
         "NEDERLANDS":["GELEERDE"],
         "SVENSKA":["LÄRDE"],
         "NORSK":["LÆRD"],
         "SUOMI":["OPPINEET"],
         "POLSKI":["UCZONY"],
         "ΕΛΛΗΝΙΚΑ":["ΛΟΓΙΟΣ"]
      };
      
      private static const SCIENTIST_NAME_TEXT:Object = {
         "ENGLISH":["SCIENTIST"],
         "ESPAÑOL":["CIENTÍFICO"],
         "FRANÇAIS":["SCIENTIFIQUE"],
         "ITALIANO":["SCIENZIATO"],
         "PORTUGUÊS":["CIENTISTA"],
         "DEUTSCH":["WISSENSCHAFTLER"],
         "NEDERLANDS":["WETENSCHAPPER"],
         "SVENSKA":["VETENSKAPSMAN"],
         "NORSK":["VITENSKAPSMANN"],
         "SUOMI":["TIEDEMIES"],
         "POLSKI":["NAUKOWIEC"],
         "ΕΛΛΗΝΙΚΑ":["ΕΠΙΣΤΗΜΟΝΑΣ"]
      };
      
      private static const GENIUS_NAME_TEXT:Object = {
         "ENGLISH":["GENIUS"],
         "ESPAÑOL":["GENIO"],
         "FRANÇAIS":["GÉNIE"],
         "ITALIANO":["GENIO"],
         "PORTUGUÊS":["GÊNIO"],
         "DEUTSCH":["GENIE"],
         "NEDERLANDS":["GENIE"],
         "SVENSKA":["GENI"],
         "NORSK":["GENI"],
         "SUOMI":["NERON"],
         "POLSKI":["GENIUSZ"],
         "ΕΛΛΗΝΙΚΑ":["ΙΔΙΟΦΥΪΑ"]
      };
      
      private static const SPACEACE_NAME_TEXT:Object = {
         "ENGLISH":["SPACE ACE"],
         "ESPAÑOL":["AS DEL ESPACIO"],
         "FRANÇAIS":["AS DE L\'ESPACE"],
         "ITALIANO":["ACE SPAZIALE"],
         "PORTUGUÊS":["ÁS DO ESPAÇO"],
         "DEUTSCH":["RAUM-ACE"],
         "NEDERLANDS":["RUIMTE-ACE"],
         "SVENSKA":["RYMDÄSS"],
         "NORSK":["ROM-ESS"],
         "SUOMI":["AVARUUS-ÄSSÄ"],
         "POLSKI":["KOSMICZNY AS"],
         "ΕΛΛΗΝΙΚΑ":["ΑΣΣΟΣ ΤΟΥ ΔΙΑΣΤΗΜΑΤΟΣ"]
      };
      
      private static const ANALYTICAL_TEXT:Object = {
         "ENGLISH":["Let\'s test FOUR key areas of your BRAIN one at a time starting with your ANALYTICAL ability! Click the button to continue!"],
         "ESPAÑOL":["¡Vamos a poner a prueba CUATRO áreas clave de tu CEREBRO una por una, comenzando con tu habilidad ANALÍTICA! ¡Haz clic en el botón para continuar!"],
         "FRANÇAIS":["Testons QUATRE domaines clés de votre CERVEAU un par un, en commençant par votre capacité ANALYTIQUE ! Cliquez sur le bouton pour continuer !"],
         "ITALIANO":["Mettiamo alla prova QUATTRO aree chiave del tuo CERVELLO una alla volta iniziando dalla tua abilità ANALITICA! Clicca il pulsante per continuare!"],
         "PORTUGUÊS":["Vamos testar QUATRO áreas principais do seu CÉREBRO uma de cada vez começando pela sua habilidade ANALÍTICA! Clique no botão para continuar!"],
         "DEUTSCH":["Wir testen VIER Schlüsselbereiche deines GEHIRNS, einer nach dem anderen, beginnend mit deiner ANALYTISCHEN Fähigkeit! Klicke auf die Schaltfläche, um fortzufahren!"],
         "NEDERLANDS":["Laten we VIER kerngebieden van je BREIN testen, één tegelijk, beginnend met je ANALYTISCH vermogen! Klik op de knop om verder te gaan!"],
         "SVENSKA":["Låt oss testa FYRA nyckelområden i din HJÄRNA en i taget, med start från din ANALYTISKA förmåga! Klicka på knappen för att fortsätta!"],
         "NORSK":["La oss teste FIRE nøkkelområder i HJERNEN din, ett om gangen, med start på din ANALYTISKE evne! Klikk på knappen for å fortsette!"],
         "SUOMI":["Testataan AIVOSI NELJÄ avainaluetta yksi kerrallaan, alkaen ANALYYTTISESTÄ kyvystäsi! Napsauta painiketta jatkaaksesi!"],
         "POLSKI":["Przetestujmy CZTERY kluczowe obszary twojego MÓZGU, jeden po drugim, zaczynając od twojej zdolności ANALITYCZNEJ! Kliknij przycisk, aby kontynuować!"],
         "ΕΛΛΗΝΙΚΑ":["Ας δοκιμάσουμε ΤΕΣΣΕΡΙΣ βασικούς τομείς του ΕΓΚΕΦΑΛΟΥ σου, έναν-έναν, ξεκινώντας με την ΑΝΑΛΥΤΙΚΗ σου ικανότητα! Κάνε κλικ στο κουμπί για να συνεχίσεις!"]
      };
      
      private static const CALCULATE_TEXT:Object = {
         "ENGLISH":["Nicely done! Now, let\'s see how quickly your brain can CALCULATE!"],
         "ESPAÑOL":["¡Bien hecho! Ahora, veamos qué tan rápido puede CALCULAR tu cerebro."],
         "FRANÇAIS":["Bien joué ! Maintenant, voyons à quelle vitesse votre cerveau peut CALCULER !"],
         "ITALIANO":["Ben fatto! Ora vediamo quanto velocemente il tuo cervello può CALCOLARE!"],
         "PORTUGUÊS":["Muito bem! Agora vamos ver quão rápido o seu cérebro consegue CALCULAR!"],
         "DEUTSCH":["Gut gemacht! Jetzt sehen wir, wie schnell dein Gehirn RECHNEN kann!"],
         "NEDERLANDS":["Goed gedaan! Laten we nu zien hoe snel je brein kan BEREKENEN!"],
         "SVENSKA":["Bra gjort! Nu ska vi se hur snabbt din hjärna kan RÄKNA!"],
         "NORSK":["Bra gjort! Nå skal vi se hvor raskt hjernen din kan REGNE!"],
         "SUOMI":["Hienoa! Katsotaanpa nyt, kuinka nopeasti aivosi voivat LASKEA!"],
         "POLSKI":["Dobra robota! Teraz zobaczmy, jak szybko twój mózg potrafi OBLICZAĆ!"],
         "ΕΛΛΗΝΙΚΑ":["Μπράβο! Τώρα ας δούμε πόσο γρήγορα μπορεί να ΥΠΟΛΟΓΙΣΕΙ ο εγκέφαλός σου!"]
      };
      
      private static const MEMORY_TEXT:Object = {
         "ENGLISH":["Great! TWO down, TWO to go! You are getting there! Time to see how good your MEMORY is."],
         "ESPAÑOL":["¡Genial! Dos pruebas hechas, dos faltan. ¡Ya casi llegas! Es hora de ver qué tan buena es tu MEMORIA."],
         "FRANÇAIS":["Super ! Deux terminés, deux restants ! Tu y es presque ! Il est temps de voir la qualité de ta MÉMOIRE."],
         "ITALIANO":["Ottimo! Due fatti, due ancora da fare! Ci sei quasi! È il momento di vedere quanto è buona la tua MEMORIA."],
         "PORTUGUÊS":["Ótimo! DUAS concluídas, DUAS restantes! Você está indo bem! Hora de ver como está sua MEMÓRIA."],
         "DEUTSCH":["Super! Zwei geschafft, zwei noch! Du bist fast am Ziel! Zeit, deine GEDÄCHTNISLEISTUNG zu testen."],
         "NEDERLANDS":["Geweldig! Twee klaar, nog twee te gaan! Je komt er wel! Tijd om je GEHEUGEN te testen."],
         "SVENSKA":["Härligt! Två klara, två kvar! Du är på väg! Dags att testa ditt MINNE."],
         "NORSK":["Flott! To ferdige, to igjen! Du er snart der! Nå er det tid for å teste HUKOMMELSEN din."],
         "SUOMI":["Hienoa! Kaksi suoritettu, kaksi jäljellä! Olet lähellä! Nyt katsotaan, kuinka hyvä MUISTISI on."],
         "POLSKI":["Świetnie! DWA zaliczone, DWA do zrobienia! Już prawie tam jesteś! Czas sprawdzić swoją PAMIĘĆ."],
         "ΕΛΛΗΝΙΚΑ":["Τέλεια! Δύο κάτω, δύο ακόμη! Είσαι κοντά! Ώρα να δούμε πόσο καλή είναι η ΜΝΗΜΗ σου."]
      };
      
      private static const VISUAL_TEXT:Object = {
         "ENGLISH":["Excellent - that\'s the memory test done! Now for the very last part - testing your VISUAL PROCESSING ability."],
         "ESPAÑOL":["¡Excelente, la prueba de memoria está hecha! Ahora vamos con la última parte: probar tu capacidad de PROCESAMIENTO VISUAL."],
         "FRANÇAIS":["Excellent - le test de mémoire est terminé ! Passons à la toute dernière partie : tester votre capacité de TRAITEMENT VISUEL."],
         "ITALIANO":["Eccellente - il test di memoria è concluso! Ora per l\'ultima parte: mettere alla prova la tua abilità di ELABORAZIONE VISIVA."],
         "PORTUGUÊS":["Excelente - o teste de memória está concluído! Agora vamos para a última parte: testar sua capacidade de PROCESSAMENTO VISUAL."],
         "DEUTSCH":["Ausgezeichnet – der Gedächtnistest ist geschafft! Jetzt kommt der allerletzte Teil: deine Fähigkeit zur VISUELLEN VERARBEITUNG."],
         "NEDERLANDS":["Uitstekend - de geheugentest is afgerond! Nu het allerlaatste deel: het testen van je VISUELE VERWERKING."],
         "SVENSKA":["Utmärkt - minnestestet är klart! Nu återstår det sista: att testa din VISUELLA BEARBETNINGSFÖRMÅGA."],
         "NORSK":["Utmerket – hukommelsestesten er fullført! Nå gjenstår den aller siste delen: å teste din VISUELLE BEHANDLINGSEVNE."],
         "SUOMI":["Erinomaista – muistitesti on tehty! Nyt viimeiseen osioon: testataan VISUAALISTA KÄSITTELYKYKYÄSI."],
         "POLSKI":["Świetnie – test pamięci zakończony! Teraz ostatnia część: sprawdzian twojej zdolności PRZETWARZANIA WZROKOWEGO."],
         "ΕΛΛΗΝΙΚΑ":["Εξαιρετικά - το τεστ μνήμης ολοκληρώθηκε! Τώρα το τελευταίο μέρος: η δοκιμή της ικανότητας ΟΠΤΙΚΗΣ ΕΠΕΞΕΡΓΑΣΙΑΣ."]
      };
      
      private static const PLAY_BUTTON_TEXT:Object = {
         "ENGLISH":"Play",
         "ESPAÑOL":"Jugar",
         "FRANÇAIS":"Jouer",
         "ITALIANO":"Gioca",
         "PORTUGUÊS":"Jogar",
         "DEUTSCH":"Spielen",
         "NEDERLANDS":"Spelen",
         "SVENSKA":"Spela",
         "NORSK":"Spill",
         "SUOMI":"Pelaa",
         "POLSKI":"Graj"
      };
      
      private static const INVITE_BUTTON_TEXT:Object = {
         "ENGLISH":"Invite",
         "ESPAÑOL":"Invitar",
         "FRANÇAIS":"Inviter",
         "ITALIANO":"Invita",
         "PORTUGUÊS":"Convidar",
         "DEUTSCH":"Einladen",
         "NEDERLANDS":"Uitnodigen",
         "SVENSKA":"Bjud in",
         "NORSK":"Inviter",
         "SUOMI":"Kutsu",
         "POLSKI":"Zaproś"
      };
      
      private static const PROFILE_BUTTON_TEXT:Object = {
         "ENGLISH":"Profile",
         "ESPAÑOL":"Perfil",
         "FRANÇAIS":"Profil",
         "ITALIANO":"Profilo",
         "PORTUGUÊS":"Perfil",
         "DEUTSCH":"Profil",
         "NEDERLANDS":"Profiel",
         "SVENSKA":"Profil",
         "NORSK":"Profil",
         "SUOMI":"Profiili",
         "POLSKI":"Profil"
      };
      
      private static const CHALLENGE_BUTTON_TEXT:Object = {
         "ENGLISH":"Challenge",
         "ESPAÑOL":"Desafío",
         "FRANÇAIS":"Défi",
         "ITALIANO":"Sfida",
         "PORTUGUÊS":"Desafio",
         "DEUTSCH":"Herausforderung",
         "NEDERLANDS":"Uitdaging",
         "SVENSKA":"Utmanning",
         "NORSK":"Utfordring",
         "SUOMI":"Haaste",
         "POLSKI":"Wyzwanie"
      };
      
      private static const TROPHIES_BUTTON_TEXT:Object = {
         "ENGLISH":"Trophies",
         "ESPAÑOL":"Trofeos",
         "FRANÇAIS":"Trophées",
         "ITALIANO":"Trofei",
         "PORTUGUÊS":"Troféus",
         "DEUTSCH":"Trophäen",
         "NEDERLANDS":"Trofeeën",
         "SVENSKA":"Troféer",
         "NORSK":"Troféer",
         "SUOMI":"Pokaalit",
         "POLSKI":"Trofea"
      };
      
      private static const PRACTICE_BUTTON_TEXT:Object = {
         "ENGLISH":"Practice",
         "ESPAÑOL":"Práctica",
         "FRANÇAIS":"Entraînement",
         "ITALIANO":"Allenamento",
         "PORTUGUÊS":"Prática",
         "DEUTSCH":"Übung",
         "NEDERLANDS":"Oefenen",
         "SVENSKA":"Träning",
         "NORSK":"Trening",
         "SUOMI":"Harjoitus",
         "POLSKI":"Ćwiczenia"
      };
      
      private static const CLASSIC_BUTTON_TEXT:Object = {
         "ENGLISH":"Classic Game",
         "ESPAÑOL":"Juego clásico",
         "FRANÇAIS":"Jeu classique",
         "ITALIANO":"Gioco classico",
         "PORTUGUÊS":"Jogo clássico",
         "DEUTSCH":"Klassisches Spiel",
         "NEDERLANDS":"Klassiek spel",
         "SVENSKA":"Klassiskt spel",
         "NORSK":"Klassisk spill",
         "SUOMI":"Klassinen peli",
         "POLSKI":"Gra klasyczna"
      };
      
      private static const PRO_BUTTON_TEXT:Object = {
         "ENGLISH":"Pro Game",
         "ESPAÑOL":"Juego pro",
         "FRANÇAIS":"Jeu pro",
         "ITALIANO":"Gioco pro",
         "PORTUGUÊS":"Jogo pro",
         "DEUTSCH":"Profi-Spiel",
         "NEDERLANDS":"Pro-spel",
         "SVENSKA":"Pro-spel",
         "NORSK":"Pro-spill",
         "SUOMI":"Pro-peli",
         "POLSKI":"Gra pro"
      };
      
      private static const BEST_SCORE_TEXT:Object = {
         "ENGLISH":"Best Score",
         "ESPAÑOL":"Récord",
         "FRANÇAIS":"Record",
         "ITALIANO":"Record",
         "PORTUGUÊS":"Recorde",
         "DEUTSCH":"Rekord",
         "NEDERLANDS":"Record",
         "SVENSKA":"Rekord",
         "NORSK":"Rekord",
         "SUOMI":"Ennätys",
         "POLSKI":"Rekord",
         "ΕΛΛΗΝΙΚΑ":"Ρεκόρ"
      };
      
      private static const AVERAGE_SCORE_TEXT:Object = {
         "ENGLISH":"Average Score",
         "ESPAÑOL":"Promedio",
         "FRANÇAIS":"Moyenne",
         "ITALIANO":"Media",
         "PORTUGUÊS":"Média",
         "DEUTSCH":"Durchschnitt",
         "NEDERLANDS":"Gemiddelde",
         "SVENSKA":"Snitt",
         "NORSK":"Snitt",
         "SUOMI":"Keskiarvo",
         "POLSKI":"Średnia",
         "ΕΛΛΗΝΙΚΑ":"Μέσος όρος"
      };
      
      private static const FINAL_EVOLUTION_TEXT:Object = {
         "ENGLISH":"Final evolution!",
         "ESPAÑOL":"¡Evolución final!",
         "FRANÇAIS":"Évolution finale !",
         "ITALIANO":"Evoluzione finale!",
         "PORTUGUÊS":"Evolução final!",
         "DEUTSCH":"Endentwicklung!",
         "NEDERLANDS":"Laatste evolutie!",
         "SVENSKA":"Slutlig evolution!",
         "NORSK":"Endelig evolusjon!",
         "SUOMI":"Lopullinen evoluutio!",
         "POLSKI":"Ostateczna ewolucja!",
         "ΕΛΛΗΝΙΚΑ":"Τελική εξέλιξη!"
      };
      
      private static const RANK_AMONG_FRIENDS_TEXT:Object = {
         "ENGLISH":"Rank among friends: ",
         "ESPAÑOL":"Rango entre amigos: ",
         "FRANÇAIS":"Classement parmi les amis : ",
         "ITALIANO":"Classifica tra amici: ",
         "PORTUGUÊS":"Ranking entre amigos: ",
         "DEUTSCH":"Rang unter Freunden: ",
         "NEDERLANDS":"Rang onder vrienden: ",
         "SVENSKA":"Rang bland vänner: ",
         "NORSK":"Rang blant venner: ",
         "SUOMI":"Sijoitus ystävien kesken: ",
         "POLSKI":"Pozycja wśród znajomych: ",
         "ΕΛΛΗΝΙΚΑ":"Κατάταξη μεταξύ φίλων: "
      };
      
      private static const TOTAL_GAMES_PLAYED_TEXT:Object = {
         "ENGLISH":" Total Games Played",
         "ESPAÑOL":" Total de juegos jugados",
         "FRANÇAIS":" Total de parties jouées",
         "ITALIANO":" Totale partite giocate",
         "PORTUGUÊS":" Total de jogos jogados",
         "DEUTSCH":" Gesamte gespielte Spiele",
         "NEDERLANDS":" Totaal gespeelde spellen",
         "SVENSKA":" Totalt spelade spel",
         "NORSK":" Totalt antall spilte spill",
         "SUOMI":" Pelit yhteensä",
         "POLSKI":" Łączna liczba rozegranych gier",
         "ΕΛΛΗΝΙΚΑ":" Συνολικά παιχνίδια που παίχτηκαν"
      };
      
      private static const FRIENDS_PLAYING_TEXT:Object = {
         "ENGLISH":" Friends Playing",
         "ESPAÑOL":" Amigos jugando",
         "FRANÇAIS":" Amis qui jouent",
         "ITALIANO":" Amici che giocano",
         "PORTUGUÊS":" Amigos jogando",
         "DEUTSCH":" Freunde spielen",
         "NEDERLANDS":" Vrienden spelen",
         "SVENSKA":" Vänner som spelar",
         "NORSK":" Venner som spiller",
         "SUOMI":" Ystäviä pelaamassa",
         "POLSKI":" Znajomi grający",
         "ΕΛΛΗΝΙΚΑ":" Φίλοι που παίζουν"
      };
      
      private static const BEST_CATEGORY_TEXT:Object = {
         "ENGLISH":"Best Category",
         "ESPAÑOL":"Mejor categoría",
         "FRANÇAIS":"Meilleure catégorie",
         "ITALIANO":"Migliore categoria",
         "PORTUGUÊS":"Melhor categoria",
         "DEUTSCH":"Beste Kategorie",
         "NEDERLANDS":"Beste categorie",
         "SVENSKA":"Bästa kategori",
         "NORSK":"Beste kategori",
         "SUOMI":"Paras kategoria",
         "POLSKI":"Najlepsza kategoria",
         "ΕΛΛΗΝΙΚΑ":"Καλύτερη κατηγορία"
      };
      
      private static const WORLD_RANK_PERCENTILE_TEXT:Object = {
         "ENGLISH":"World Rank Percentile: ",
         "ESPAÑOL":"Percentil de rango mundial: ",
         "FRANÇAIS":"Centile de rang mondial : ",
         "ITALIANO":"Percentile di rango mondiale: ",
         "PORTUGUÊS":"Percentil de classificação mundial: ",
         "DEUTSCH":"Weltrang-Prozentrang: ",
         "NEDERLANDS":"Wereldrangpercentiel: ",
         "SVENSKA":"Världs-rankingpercentil: ",
         "NORSK":"Verdensrang percentil: ",
         "SUOMI":"Maailman sijoituspercentiili: ",
         "POLSKI":"Percentyl światowego rankingu: ",
         "ΕΛΛΗΝΙΚΑ":"Παγκόσμιο ποσοστιαίο κατάταξης: "
      };
      
      private static const CALENDAR_BUTTON_TEXT:Object = {
         "ENGLISH":"Calendar",
         "ESPAÑOL":"Calendario",
         "FRANÇAIS":"Calendrier",
         "ITALIANO":"Calendario",
         "PORTUGUÊS":"Calendário",
         "DEUTSCH":"Kalender",
         "NEDERLANDS":"Kalender",
         "SVENSKA":"Kalender",
         "NORSK":"Kalender",
         "SUOMI":"Kalenteri",
         "POLSKI":"Kalendarz"
      };
      
      private static const CONTINUE_BUTTON_TEXT:Object = {
         "ENGLISH":"Continue",
         "ESPAÑOL":"Continuar",
         "FRANÇAIS":"Continuer",
         "ITALIANO":"Continua",
         "PORTUGUÊS":"Continuar",
         "DEUTSCH":"Fortsetzen",
         "NEDERLANDS":"Doorgaan",
         "SVENSKA":"Fortsätt",
         "NORSK":"Fortsett",
         "SUOMI":"Jatka",
         "POLSKI":"Kontynuuj"
      };
      
      private static const UPLOAD_FAILED_TEXT:Object = {
         "ENGLISH":"Upload failed, retry?",
         "ESPAÑOL":"Error al subir, ¿reintentar?",
         "FRANÇAIS":"Échec du téléversement, réessayer ?",
         "ITALIANO":"Caricamento fallito, riprovare?",
         "PORTUGUÊS":"Falha no envio, tentar novamente?",
         "DEUTSCH":"Hochladen fehlgeschlagen, erneut versuchen?",
         "NEDERLANDS":"Upload mislukt, opnieuw proberen?",
         "SVENSKA":"Uppladdning misslyckades, försök igen?",
         "NORSK":"Opplasting mislyktes, prøve igjen?",
         "SUOMI":"Lataus epäonnistui, yritetäänkö uudelleen?",
         "POLSKI":"Przesyłanie nie powiodło się, spróbować ponownie?",
         "ΕΛΛΗΝΙΚΑ":"Αποτυχία μεταφόρτωσης, επανάληψη;"
      };
      
      private static const TIMES_UP_TEXT:Object = {
         "ENGLISH":"TIME\'S UP",
         "ESPAÑOL":"¡TIEMPO!",
         "FRANÇAIS":"TEMPS!",
         "ITALIANO":"TEMPO!",
         "PORTUGUÊS":"TEMPO!",
         "DEUTSCH":"ZEIT!",
         "NEDERLANDS":"TIJD!",
         "SVENSKA":"TID!",
         "NORSK":"TID!",
         "SUOMI":"AIKA!",
         "POLSKI":"CZAS!"
      };
      
      private static const QUIT_GAME_TEXT:Object = {
         "ENGLISH":"Quit Game?",
         "ESPAÑOL":"¿Abandonar la partida?",
         "FRANÇAIS":"Quitter le jeu ?",
         "ITALIANO":"Uscire dal gioco?",
         "PORTUGUÊS":"Sair do jogo?",
         "DEUTSCH":"Spiel beenden?",
         "NEDERLANDS":"Spel afsluiten?",
         "SVENSKA":"Avsluta spel?",
         "NORSK":"Avslutt spill?",
         "SUOMI":"Poistua pelistä?",
         "POLSKI":"Opuścić grę?",
         "ΕΛΛΗΝΙΚΑ":"Έξοδος από το παιχνίδι;"
      };
       
      
      public function LanguageTranslation()
      {
         super();
      }
      
      public static function getNumbersText(lang:String) : Array
      {
         if(NUMBERS_TEXT.hasOwnProperty(lang))
         {
            return NUMBERS_TEXT[lang];
         }
         return NUMBERS_TEXT["ENGLISH"];
      }
      
      public static function getInviteText1(lang:String) : String
      {
         if(INVITE_TEXT_1.hasOwnProperty(lang))
         {
            return INVITE_TEXT_1[lang];
         }
         return INVITE_TEXT_1["ENGLISH"];
      }
      
      public static function getInviteText2(lang:String) : Array
      {
         if(INVITE_TEXT_2.hasOwnProperty(lang))
         {
            return INVITE_TEXT_2[lang];
         }
         return INVITE_TEXT_2["ENGLISH"];
      }
      
      public static function getWelcomeText1(lang:String) : String
      {
         if(WELCOME_TEXT_1.hasOwnProperty(lang))
         {
            return WELCOME_TEXT_1[lang];
         }
         return WELCOME_TEXT_1["ENGLISH"];
      }
      
      public static function getWelcomeText2(lang:String) : Array
      {
         if(WELCOME_TEXT_2.hasOwnProperty(lang))
         {
            return WELCOME_TEXT_2[lang];
         }
         return WELCOME_TEXT_2["ENGLISH"];
      }
      
      public static function getWelcomeText3(lang:String) : Array
      {
         if(WELCOME_TEXT_3.hasOwnProperty(lang))
         {
            return WELCOME_TEXT_3[lang];
         }
         return WELCOME_TEXT_3["ENGLISH"];
      }
      
      public static function getScoreText1(lang:String) : String
      {
         if(SCORE_TEXT_1.hasOwnProperty(lang))
         {
            return SCORE_TEXT_1[lang];
         }
         return SCORE_TEXT_1["ENGLISH"];
      }
      
      public static function getScoreText2(lang:String) : String
      {
         if(SCORE_TEXT_2.hasOwnProperty(lang))
         {
            return SCORE_TEXT_2[lang];
         }
         return SCORE_TEXT_2["ENGLISH"];
      }
      
      public static function getScoreText3(lang:String) : String
      {
         if(SCORE_TEXT_3.hasOwnProperty(lang))
         {
            return SCORE_TEXT_3[lang];
         }
         return SCORE_TEXT_3["ENGLISH"];
      }
      
      public static function getBrainTypeText1(lang:String) : String
      {
         if(BRAINTYPE_TEXT_1.hasOwnProperty(lang))
         {
            return BRAINTYPE_TEXT_1[lang];
         }
         return BRAINTYPE_TEXT_1["ENGLISH"];
      }
      
      public static function getBrainTypeText2(lang:String) : String
      {
         if(BRAINTYPE_TEXT_2.hasOwnProperty(lang))
         {
            return BRAINTYPE_TEXT_2[lang];
         }
         return BRAINTYPE_TEXT_2["ENGLISH"];
      }
      
      public static function getBrainTypeText3(lang:String) : String
      {
         if(BRAINTYPE_TEXT_3.hasOwnProperty(lang))
         {
            return BRAINTYPE_TEXT_3[lang];
         }
         return BRAINTYPE_TEXT_3["ENGLISH"];
      }
      
      public static function getSumUpText(lang:String) : String
      {
         if(SUMUP_TEXT.hasOwnProperty(lang))
         {
            return SUMUP_TEXT[lang];
         }
         return SUMUP_TEXT["ENGLISH"];
      }
      
      public static function getAmoebaText(lang:String) : String
      {
         if(AMOEBA_TEXT.hasOwnProperty(lang))
         {
            return AMOEBA_TEXT[lang];
         }
         return AMOEBA_TEXT["ENGLISH"];
      }
      
      public static function getEarthwormText(lang:String) : String
      {
         if(EARTHWORM_TEXT.hasOwnProperty(lang))
         {
            return EARTHWORM_TEXT[lang];
         }
         return EARTHWORM_TEXT["ENGLISH"];
      }
      
      public static function getSnailText(lang:String) : String
      {
         if(SNAIL_TEXT.hasOwnProperty(lang))
         {
            return SNAIL_TEXT[lang];
         }
         return SNAIL_TEXT["ENGLISH"];
      }
      
      public static function getRatText(lang:String) : String
      {
         if(RAT_TEXT.hasOwnProperty(lang))
         {
            return RAT_TEXT[lang];
         }
         return RAT_TEXT["ENGLISH"];
      }
      
      public static function getCatText(lang:String) : String
      {
         if(CAT_TEXT.hasOwnProperty(lang))
         {
            return CAT_TEXT[lang];
         }
         return CAT_TEXT["ENGLISH"];
      }
      
      public static function getDogText(lang:String) : String
      {
         if(DOG_TEXT.hasOwnProperty(lang))
         {
            return DOG_TEXT[lang];
         }
         return DOG_TEXT["ENGLISH"];
      }
      
      public static function getGoatText(lang:String) : String
      {
         if(GOAT_TEXT.hasOwnProperty(lang))
         {
            return GOAT_TEXT[lang];
         }
         return GOAT_TEXT["ENGLISH"];
      }
      
      public static function getChimpText(lang:String) : String
      {
         if(CHIMP_TEXT.hasOwnProperty(lang))
         {
            return CHIMP_TEXT[lang];
         }
         return CHIMP_TEXT["ENGLISH"];
      }
      
      public static function getGorillaText(lang:String) : String
      {
         if(GORILLA_TEXT.hasOwnProperty(lang))
         {
            return GORILLA_TEXT[lang];
         }
         return GORILLA_TEXT["ENGLISH"];
      }
      
      public static function getMissingLinkText(lang:String) : String
      {
         if(MISSINGLINK_TEXT.hasOwnProperty(lang))
         {
            return MISSINGLINK_TEXT[lang];
         }
         return MISSINGLINK_TEXT["ENGLISH"];
      }
      
      public static function getNeanderthalText(lang:String) : String
      {
         if(NEANDERTHAL_TEXT.hasOwnProperty(lang))
         {
            return NEANDERTHAL_TEXT[lang];
         }
         return NEANDERTHAL_TEXT["ENGLISH"];
      }
      
      public static function getAverageJoeText(lang:String) : String
      {
         if(AVERAGEJOE_TEXT.hasOwnProperty(lang))
         {
            return AVERAGEJOE_TEXT[lang];
         }
         return AVERAGEJOE_TEXT["ENGLISH"];
      }
      
      public static function getGeekText(lang:String) : String
      {
         if(GEEK_TEXT.hasOwnProperty(lang))
         {
            return GEEK_TEXT[lang];
         }
         return GEEK_TEXT["ENGLISH"];
      }
      
      public static function getNerdText(lang:String) : String
      {
         if(NERD_TEXT.hasOwnProperty(lang))
         {
            return NERD_TEXT[lang];
         }
         return NERD_TEXT["ENGLISH"];
      }
      
      public static function getScholarText(lang:String) : String
      {
         if(SCHOLAR_TEXT.hasOwnProperty(lang))
         {
            return SCHOLAR_TEXT[lang];
         }
         return SCHOLAR_TEXT["ENGLISH"];
      }
      
      public static function getScientistText(lang:String) : String
      {
         if(SCIENTIST_TEXT.hasOwnProperty(lang))
         {
            return SCIENTIST_TEXT[lang];
         }
         return SCIENTIST_TEXT["ENGLISH"];
      }
      
      public static function getGeniusText(lang:String) : String
      {
         if(GENIUS_TEXT.hasOwnProperty(lang))
         {
            return GENIUS_TEXT[lang];
         }
         return GENIUS_TEXT["ENGLISH"];
      }
      
      public static function getSpaceAceText(lang:String) : String
      {
         if(SPACEACE_TEXT.hasOwnProperty(lang))
         {
            return SPACEACE_TEXT[lang];
         }
         return SPACEACE_TEXT["ENGLISH"];
      }
      
      public static function getCyborgText(lang:String) : String
      {
         if(CYBORG_TEXT.hasOwnProperty(lang))
         {
            return CYBORG_TEXT[lang];
         }
         return CYBORG_TEXT["ENGLISH"];
      }
      
      public static function getAlienText(lang:String) : String
      {
         if(ALIEN_TEXT.hasOwnProperty(lang))
         {
            return ALIEN_TEXT[lang];
         }
         return ALIEN_TEXT["ENGLISH"];
      }
      
      public static function getSquidlianText(lang:String) : String
      {
         if(SQUIDLIAN_TEXT.hasOwnProperty(lang))
         {
            return SQUIDLIAN_TEXT[lang];
         }
         return SQUIDLIAN_TEXT["ENGLISH"];
      }
      
      public static function getBitBotText(lang:String) : String
      {
         if(BITBOT_TEXT.hasOwnProperty(lang))
         {
            return BITBOT_TEXT[lang];
         }
         return BITBOT_TEXT["ENGLISH"];
      }
      
      public static function getSpaceBotText(lang:String) : String
      {
         if(SPACEBOT_TEXT.hasOwnProperty(lang))
         {
            return SPACEBOT_TEXT[lang];
         }
         return SPACEBOT_TEXT["ENGLISH"];
      }
      
      public static function getCalcuBotText(lang:String) : String
      {
         if(CALCUBOT_TEXT.hasOwnProperty(lang))
         {
            return CALCUBOT_TEXT[lang];
         }
         return CALCUBOT_TEXT["ENGLISH"];
      }
      
      public static function getEncephaloBotText(lang:String) : String
      {
         if(ENCEPHALOBOT_TEXT.hasOwnProperty(lang))
         {
            return ENCEPHALOBOT_TEXT[lang];
         }
         return ENCEPHALOBOT_TEXT["ENGLISH"];
      }
      
      public static function getBrainBotText(lang:String) : String
      {
         if(BRAINBOT_TEXT.hasOwnProperty(lang))
         {
            return BRAINBOT_TEXT[lang];
         }
         return BRAINBOT_TEXT["ENGLISH"];
      }
      
      public static function getNeuroBotText(lang:String) : String
      {
         if(NEUROBOT_TEXT.hasOwnProperty(lang))
         {
            return NEUROBOT_TEXT[lang];
         }
         return NEUROBOT_TEXT["ENGLISH"];
      }
      
      public static function getComputronText(lang:String) : String
      {
         if(COMPUTRON_TEXT.hasOwnProperty(lang))
         {
            return COMPUTRON_TEXT[lang];
         }
         return COMPUTRON_TEXT["ENGLISH"];
      }
      
      public static function getXenosText(lang:String) : String
      {
         if(XENOS_TEXT.hasOwnProperty(lang))
         {
            return XENOS_TEXT[lang];
         }
         return XENOS_TEXT["ENGLISH"];
      }
      
      public static function getNeuronianText(lang:String) : String
      {
         if(NEURONIAN_TEXT.hasOwnProperty(lang))
         {
            return NEURONIAN_TEXT[lang];
         }
         return NEURONIAN_TEXT["ENGLISH"];
      }
      
      public static function getAeonianText(lang:String) : String
      {
         if(AEONIAN_TEXT.hasOwnProperty(lang))
         {
            return AEONIAN_TEXT[lang];
         }
         return AEONIAN_TEXT["ENGLISH"];
      }
      
      public static function getGalaxionText(lang:String) : String
      {
         if(GALAXION_TEXT.hasOwnProperty(lang))
         {
            return GALAXION_TEXT[lang];
         }
         return GALAXION_TEXT["ENGLISH"];
      }
      
      public static function getGameSelectText(lang:String) : String
      {
         if(GAMESELECT_TEXT.hasOwnProperty(lang))
         {
            return GAMESELECT_TEXT[lang];
         }
         return GAMESELECT_TEXT["ENGLISH"];
      }
      
      public static function getPracticeText1(lang:String) : String
      {
         if(PRACTICE_TEXT_1.hasOwnProperty(lang))
         {
            return PRACTICE_TEXT_1[lang];
         }
         return PRACTICE_TEXT_1["ENGLISH"];
      }
      
      public static function getPracticeText2(lang:String) : String
      {
         if(PRACTICE_TEXT_2.hasOwnProperty(lang))
         {
            return PRACTICE_TEXT_2[lang];
         }
         return PRACTICE_TEXT_2["ENGLISH"];
      }
      
      public static function getPracticeText3(lang:String) : String
      {
         if(PRACTICE_TEXT_3.hasOwnProperty(lang))
         {
            return PRACTICE_TEXT_3[lang];
         }
         return PRACTICE_TEXT_3["ENGLISH"];
      }
      
      public static function getPracticeText4(lang:String) : String
      {
         if(PRACTICE_TEXT_4.hasOwnProperty(lang))
         {
            return PRACTICE_TEXT_4[lang];
         }
         return PRACTICE_TEXT_4["ENGLISH"];
      }
      
      public static function getPracticeText5(lang:String) : String
      {
         if(PRACTICE_TEXT_5.hasOwnProperty(lang))
         {
            return PRACTICE_TEXT_5[lang];
         }
         return PRACTICE_TEXT_5["ENGLISH"];
      }
      
      public static function getProGameText(lang:String) : String
      {
         if(PROGAME_TEXT.hasOwnProperty(lang))
         {
            return PROGAME_TEXT[lang];
         }
         return PROGAME_TEXT["ENGLISH"];
      }
      
      public static function getBalanceText(lang:String) : String
      {
         if(BALANCE_TEXT.hasOwnProperty(lang))
         {
            return BALANCE_TEXT[lang];
         }
         return BALANCE_TEXT["ENGLISH"];
      }
      
      public static function getCubeCounterText(lang:String) : String
      {
         if(CUBECOUNTER_TEXT.hasOwnProperty(lang))
         {
            return CUBECOUNTER_TEXT[lang];
         }
         return CUBECOUNTER_TEXT["ENGLISH"];
      }
      
      public static function getCarPathText(lang:String) : String
      {
         if(CARPATH_TEXT.hasOwnProperty(lang))
         {
            return CARPATH_TEXT[lang];
         }
         return CARPATH_TEXT["ENGLISH"];
      }
      
      public static function getMissingNumberText(lang:String) : String
      {
         if(MISSINGNUMBER_TEXT.hasOwnProperty(lang))
         {
            return MISSINGNUMBER_TEXT[lang];
         }
         return MISSINGNUMBER_TEXT["ENGLISH"];
      }
      
      public static function getMissingSignText(lang:String) : String
      {
         if(MISSINGSIGN_TEXT.hasOwnProperty(lang))
         {
            return MISSINGSIGN_TEXT[lang];
         }
         return MISSINGSIGN_TEXT["ENGLISH"];
      }
      
      public static function getMathCombText(lang:String) : String
      {
         if(MATHCOMB_TEXT.hasOwnProperty(lang))
         {
            return MATHCOMB_TEXT[lang];
         }
         return MATHCOMB_TEXT["ENGLISH"];
      }
      
      public static function getCardPairsText(lang:String) : String
      {
         if(CARDPAIRS_TEXT.hasOwnProperty(lang))
         {
            return CARDPAIRS_TEXT[lang];
         }
         return CARDPAIRS_TEXT["ENGLISH"];
      }
      
      public static function getShapeOrderText(lang:String) : String
      {
         if(SHAPEORDER_TEXT.hasOwnProperty(lang))
         {
            return SHAPEORDER_TEXT[lang];
         }
         return SHAPEORDER_TEXT["ENGLISH"];
      }
      
      public static function getActionSequenceText(lang:String) : String
      {
         if(ACTIONSEQUENCE_TEXT.hasOwnProperty(lang))
         {
            return ACTIONSEQUENCE_TEXT[lang];
         }
         return ACTIONSEQUENCE_TEXT["ENGLISH"];
      }
      
      public static function getAsteroidsText(lang:String) : String
      {
         if(ASTEROIDS_TEXT.hasOwnProperty(lang))
         {
            return ASTEROIDS_TEXT[lang];
         }
         return ASTEROIDS_TEXT["ENGLISH"];
      }
      
      public static function getJigsawText(lang:String) : String
      {
         if(JIGSAW_TEXT.hasOwnProperty(lang))
         {
            return JIGSAW_TEXT[lang];
         }
         return JIGSAW_TEXT["ENGLISH"];
      }
      
      public static function getHexPathText(lang:String) : String
      {
         if(HEXPATH_TEXT.hasOwnProperty(lang))
         {
            return HEXPATH_TEXT[lang];
         }
         return HEXPATH_TEXT["ENGLISH"];
      }
      
      public static function getAmoebaNameText(lang:String) : String
      {
         if(AMOEBA_NAME_TEXT.hasOwnProperty(lang))
         {
            return AMOEBA_NAME_TEXT[lang];
         }
         return AMOEBA_NAME_TEXT["ENGLISH"];
      }
      
      public static function getEarthwormNameText(lang:String) : String
      {
         if(EARTHWORM_NAME_TEXT.hasOwnProperty(lang))
         {
            return EARTHWORM_NAME_TEXT[lang];
         }
         return EARTHWORM_NAME_TEXT["ENGLISH"];
      }
      
      public static function getSnailNameText(lang:String) : String
      {
         if(SNAIL_NAME_TEXT.hasOwnProperty(lang))
         {
            return SNAIL_NAME_TEXT[lang];
         }
         return SNAIL_NAME_TEXT["ENGLISH"];
      }
      
      public static function getRatNameText(lang:String) : String
      {
         if(RAT_NAME_TEXT.hasOwnProperty(lang))
         {
            return RAT_NAME_TEXT[lang];
         }
         return RAT_NAME_TEXT["ENGLISH"];
      }
      
      public static function getCatNameText(lang:String) : String
      {
         if(CAT_NAME_TEXT.hasOwnProperty(lang))
         {
            return CAT_NAME_TEXT[lang];
         }
         return CAT_NAME_TEXT["ENGLISH"];
      }
      
      public static function getDogNameText(lang:String) : String
      {
         if(DOG_NAME_TEXT.hasOwnProperty(lang))
         {
            return DOG_NAME_TEXT[lang];
         }
         return DOG_NAME_TEXT["ENGLISH"];
      }
      
      public static function getGoatNameText(lang:String) : String
      {
         if(GOAT_NAME_TEXT.hasOwnProperty(lang))
         {
            return GOAT_NAME_TEXT[lang];
         }
         return GOAT_NAME_TEXT["ENGLISH"];
      }
      
      public static function getChimpNameText(lang:String) : String
      {
         if(CHIMP_NAME_TEXT.hasOwnProperty(lang))
         {
            return CHIMP_NAME_TEXT[lang];
         }
         return CHIMP_NAME_TEXT["ENGLISH"];
      }
      
      public static function getGorillaNameText(lang:String) : String
      {
         if(GORILLA_NAME_TEXT.hasOwnProperty(lang))
         {
            return GORILLA_NAME_TEXT[lang];
         }
         return GORILLA_NAME_TEXT["ENGLISH"];
      }
      
      public static function getMissingLinkNameText(lang:String) : String
      {
         if(MISSINGLINK_NAME_TEXT.hasOwnProperty(lang))
         {
            return MISSINGLINK_NAME_TEXT[lang];
         }
         return MISSINGLINK_NAME_TEXT["ENGLISH"];
      }
      
      public static function getNeanderthalNameText(lang:String) : String
      {
         if(NEANDERTHAL_NAME_TEXT.hasOwnProperty(lang))
         {
            return NEANDERTHAL_NAME_TEXT[lang];
         }
         return NEANDERTHAL_NAME_TEXT["ENGLISH"];
      }
      
      public static function getAverageJoeNameText(lang:String) : String
      {
         if(AVERAGEJOE_NAME_TEXT.hasOwnProperty(lang))
         {
            return AVERAGEJOE_NAME_TEXT[lang];
         }
         return AVERAGEJOE_NAME_TEXT["ENGLISH"];
      }
      
      public static function getScholarNameText(lang:String) : String
      {
         if(SCHOLAR_NAME_TEXT.hasOwnProperty(lang))
         {
            return SCHOLAR_NAME_TEXT[lang];
         }
         return SCHOLAR_NAME_TEXT["ENGLISH"];
      }
      
      public static function getScientistNameText(lang:String) : String
      {
         if(SCIENTIST_NAME_TEXT.hasOwnProperty(lang))
         {
            return SCIENTIST_NAME_TEXT[lang];
         }
         return SCIENTIST_NAME_TEXT["ENGLISH"];
      }
      
      public static function getGeniusNameText(lang:String) : String
      {
         if(GENIUS_NAME_TEXT.hasOwnProperty(lang))
         {
            return GENIUS_NAME_TEXT[lang];
         }
         return GENIUS_NAME_TEXT["ENGLISH"];
      }
      
      public static function getSpaceAceNameText(lang:String) : String
      {
         if(SPACEACE_NAME_TEXT.hasOwnProperty(lang))
         {
            return SPACEACE_NAME_TEXT[lang];
         }
         return SPACEACE_NAME_TEXT["ENGLISH"];
      }
      
      public static function getAnalyticalText(lang:String) : String
      {
         if(ANALYTICAL_TEXT.hasOwnProperty(lang))
         {
            return ANALYTICAL_TEXT[lang];
         }
         return ANALYTICAL_TEXT["ENGLISH"];
      }
      
      public static function getCalculateText(lang:String) : String
      {
         if(CALCULATE_TEXT.hasOwnProperty(lang))
         {
            return CALCULATE_TEXT[lang];
         }
         return CALCULATE_TEXT["ENGLISH"];
      }
      
      public static function getMemoryText(lang:String) : String
      {
         if(MEMORY_TEXT.hasOwnProperty(lang))
         {
            return MEMORY_TEXT[lang];
         }
         return MEMORY_TEXT["ENGLISH"];
      }
      
      public static function getVisualText(lang:String) : String
      {
         if(VISUAL_TEXT.hasOwnProperty(lang))
         {
            return VISUAL_TEXT[lang];
         }
         return VISUAL_TEXT["ENGLISH"];
      }
      
      public static function getPlayButtonText(lang:String) : String
      {
         if(PLAY_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return PLAY_BUTTON_TEXT[lang];
         }
         return PLAY_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getInviteButtonText(lang:String) : String
      {
         if(INVITE_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return INVITE_BUTTON_TEXT[lang];
         }
         return INVITE_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getProfileButtonText(lang:String) : String
      {
         if(PROFILE_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return PROFILE_BUTTON_TEXT[lang];
         }
         return PROFILE_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getChallengeButtonText(lang:String) : String
      {
         if(CHALLENGE_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return CHALLENGE_BUTTON_TEXT[lang];
         }
         return CHALLENGE_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getTrophiesButtonText(lang:String) : String
      {
         if(TROPHIES_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return TROPHIES_BUTTON_TEXT[lang];
         }
         return TROPHIES_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getPracticeButtonText(lang:String) : String
      {
         if(PRACTICE_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return PRACTICE_BUTTON_TEXT[lang];
         }
         return PRACTICE_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getClassicButtonText(lang:String) : String
      {
         if(CLASSIC_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return CLASSIC_BUTTON_TEXT[lang];
         }
         return CLASSIC_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getProButtonText(lang:String) : String
      {
         if(PRO_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return PRO_BUTTON_TEXT[lang];
         }
         return PRO_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getBestScoreText(lang:String) : String
      {
         if(BEST_SCORE_TEXT.hasOwnProperty(lang))
         {
            return BEST_SCORE_TEXT[lang];
         }
         return BEST_SCORE_TEXT["ENGLISH"];
      }
      
      public static function getAverageScoreText(lang:String) : String
      {
         if(AVERAGE_SCORE_TEXT.hasOwnProperty(lang))
         {
            return AVERAGE_SCORE_TEXT[lang];
         }
         return AVERAGE_SCORE_TEXT["ENGLISH"];
      }
      
      public static function getFinalEvolutionText(lang:String) : String
      {
         if(FINAL_EVOLUTION_TEXT.hasOwnProperty(lang))
         {
            return FINAL_EVOLUTION_TEXT[lang];
         }
         return FINAL_EVOLUTION_TEXT["ENGLISH"];
      }
      
      public static function getRankAmongFriendsText(lang:String) : String
      {
         if(RANK_AMONG_FRIENDS_TEXT.hasOwnProperty(lang))
         {
            return RANK_AMONG_FRIENDS_TEXT[lang];
         }
         return RANK_AMONG_FRIENDS_TEXT["ENGLISH"];
      }
      
      public static function getTotalGamesPlayedText(lang:String) : String
      {
         if(TOTAL_GAMES_PLAYED_TEXT.hasOwnProperty(lang))
         {
            return TOTAL_GAMES_PLAYED_TEXT[lang];
         }
         return TOTAL_GAMES_PLAYED_TEXT["ENGLISH"];
      }
      
      public static function getFriendsPlayingText(lang:String) : String
      {
         if(FRIENDS_PLAYING_TEXT.hasOwnProperty(lang))
         {
            return FRIENDS_PLAYING_TEXT[lang];
         }
         return FRIENDS_PLAYING_TEXT["ENGLISH"];
      }
      
      public static function getBestCategoryText(lang:String) : String
      {
         if(BEST_CATEGORY_TEXT.hasOwnProperty(lang))
         {
            return BEST_CATEGORY_TEXT[lang];
         }
         return BEST_CATEGORY_TEXT["ENGLISH"];
      }
      
      public static function getWorldRankPercentileText(lang:String) : String
      {
         if(WORLD_RANK_PERCENTILE_TEXT.hasOwnProperty(lang))
         {
            return WORLD_RANK_PERCENTILE_TEXT[lang];
         }
         return WORLD_RANK_PERCENTILE_TEXT["ENGLISH"];
      }
      
      public static function getCalendarButtonText(lang:String) : String
      {
         if(CALENDAR_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return CALENDAR_BUTTON_TEXT[lang];
         }
         return CALENDAR_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getContinueButtonText(lang:String) : String
      {
         if(CONTINUE_BUTTON_TEXT.hasOwnProperty(lang))
         {
            return CONTINUE_BUTTON_TEXT[lang];
         }
         return CONTINUE_BUTTON_TEXT["ENGLISH"];
      }
      
      public static function getUploadFailedText(lang:String) : String
      {
         if(UPLOAD_FAILED_TEXT.hasOwnProperty(lang))
         {
            return UPLOAD_FAILED_TEXT[lang];
         }
         return UPLOAD_FAILED_TEXT["ENGLISH"];
      }
      
      public static function getTimesUpText(lang:String) : String
      {
         if(TIMES_UP_TEXT.hasOwnProperty(lang))
         {
            return TIMES_UP_TEXT[lang];
         }
         return TIMES_UP_TEXT["ENGLISH"];
      }
      
      public static function getQuitGameText(lang:String) : String
      {
         if(QUIT_GAME_TEXT.hasOwnProperty(lang))
         {
            return QUIT_GAME_TEXT[lang];
         }
         return QUIT_GAME_TEXT["ENGLISH"];
      }
   }
}
