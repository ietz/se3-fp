#lang racket

(require test-engine/racket-tests)

; SE3:FP Hausaufgaben 02
; 
; Gruppe 11
; 6808046 Tim Pietz
; 6792069 Hung Quan Vu

; Aufgabe 1
; 
;  1. miau -> 'Plueschi
;     Weil miau = 'Plueschi
; 
;  2. katze -> 'Plueschi
;     katze wurde auf den Wert von miau gesetzt, nachdem dieser auf 'Plueschi gesetzt wurde
; 
;  3. tiger -> 'miau
;     Weil tieger auf das Symbol 
; 
;  4. (quote katze) -> 'katze
;     Weil die Funktion quote das halt so macht
; 
;  5. (eval tiger) -> 'Plueschi
;     Weil die Funktion eval den Wert das Argument auswertet
; 
;  6. (eval katze) -> Error
;     Weil die eval versucht den Wert von katze, 'Plueschi auszuwerten, es jedoch nicht definiert ist
; 
;  7. (eval 'tiger) -> 'miau
;     Wertet Symbol 'tiger als Variable aus, welche den Wert 'miau hat
; 
;  8. (welcherNameGiltWo 'harry 'potter) -> 'harry
;     Da let ohne * verwendet wurde, wird PersonA bei der Definition von PersonC nicht als die direkt
;     zuvor definierte Variable interpretiert, sondern als der Parameter 
; 
;  9. (cdddr xs1) -> '(miau katze)
;     Auf die Liste xs1 wird drei mal cdr angewandt, d.h. erste drei Elemente werden entfernt
; 
; 10. (cdr xs2) -> '(Plueschi)
;     Vorderes Element der Liste xs2 wird entfernt, die Werte der Variablen miau und katze enthält
;
;>> Warum unterscheiden sich die Ergebnisse der Aufgaben 10 und 9 (Werte vs. Symbole)

; 11. (cdr xs3) -> 'Plueschi
;     Ähnlich wie zuvor, nur dass das erste Element eines Pairs entfernt wird

;>> Woraus ergibt sich hier das Symbol 'Plueschi und nicht die Liste '(Plueschi)
; 
; 12. (eval (sqrt 3)) -> 1.7320508
;     Eval wird auf das Ergebnis von (sqrt 3) angewandt. Zahlen werden zu sich selber ausgewertet
;

;>> 13. und 14. fehlen

;>> 6 Pkt.

;
; Aufgabe 2
; Teilaufgabe 2.1

(define (fak n)
  (if (= n 0)
      1
      (* n (fak (- n 1)))))

(check-expect (fak 0) 1)
(check-expect (fak 1) 1)
(check-expect (fak 2) 2)
(check-expect (fak 3) 6)
(check-expect (fak 1000) 402387260077093773543702433923003985719374864210714632543799910429938512398629020592044208486969404800479988610197196058631666872994808558901323829669944590997424504087073759918823627727188732519779505950995276120874975462497043601418278094646496291056393887437886487337119181045825783647849977012476632889835955735432513185323958463075557409114262417474349347553428646576611667797396668820291207379143853719588249808126867838374559731746136085379534524221586593201928090878297308431392844403281231558611036976801357304216168747609675871348312025478589320767169132448426236131412508780208000261683151027341827977704784635868170164365024153691398281264810213092761244896359928705114964975419909342221566832572080821333186116811553615836546984046708975602900950537616475847728421889679646244945160765353408198901385442487984959953319101723355556602139450399736280750137837615307127761926849034352625200015888535147331611702103968175921510907788019393178114194545257223865541461062892187960223838971476088506276862967146674697562911234082439208160153780889893964518263243671616762179168909779911903754031274622289988005195444414282012187361745992642956581746628302955570299024324153181617210465832036786906117260158783520751516284225540265170483304226143974286933061690897968482590125458327168226458066526769958652682272807075781391858178889652208164348344825993266043367660176999612831860788386150279465955131156552036093988180612138558600301435694527224206344631797460594682573103790084024432438465657245014402821885252470935190620929023136493273497565513958720559654228749774011413346962715422845862377387538230483865688976461927383814900140767310446640259899490222221765904339901886018566526485061799702356193897017860040811889729918311021171229845901641921068884387121855646124960798722908519296819372388642614839657382291123125024186649353143970137428531926649875337218940694281434118520158014123344828015051399694290153483077644569099073152433278288269864602789864321139083506217095002597389863554277196742822248757586765752344220207573630569498825087968928162753848863396909959826280956121450994871701244516461260379029309120889086942028510640182154399457156805941872748998094254742173582401063677404595741785160829230135358081840096996372524230560855903700624271243416909004153690105933983835777939410970027753472000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)

;>> Kommentare.
;>> 2 Pkt.

; Teilaufgabe 2.2
;
; Per Anforderung, zusätzlich noch für Exp. < 0

(define (power r n)
  (cond
    [(< n 0) (/ 1 (power r (- n)))]
    [(= n 0) 1]
    [(odd? n) (* r (power r (- n 1)))]
    [else (sqr (power r (/ n 2)))]))

(check-within (power 0.5 4) 0.0625 0.0)
(check-within (power 1 50) 1 0.0)
(check-within (power 12.55 3) 1976.656375 0.0001)
(check-within (power -1 1001) -1 0.0)
(check-within (power 10 -1) 0.1 0.0)

;>> 3 Pkt.

; Teilaufgabe 2.3
;
; euler-hilf berechnet jeweils ab einem Glied der Reihe, wobei der jeweilige Wert basierend auf dem
; Indexparameter berechnet wird.
; euler-limit beschreibt die Abbruchgrenze

(define euler-limit #e1E-1000)

(define (euler-hilf n)
  (let ((wert (/ (+ n 1) (fak n))))
    (if (< wert euler-limit)
        0
        (+ wert (euler-hilf (+ n 1))))))

(define euler (/ (euler-hilf 0) 2))

(check-within (floor (* euler (power 10 999))) 2718281828459045235360287471352662497757247093699959574966967627724076630353547594571382178525166427427466391932003059921817413596629043572900334295260595630738132328627943490763233829880753195251019011573834187930702154089149934884167509244761460668082264800168477411853742345442437107539077744992069551702761838606261331384583000752044933826560297606737113200709328709127443747047230696977209310141692836819025515108657463772111252389784425056953696770785449969967946864454905987931636889230098793127736178215424999229576351482208269895193668033182528869398496465105820939239829488793320362509443117301238197068416140397019837679320683282376464804295311802328782509819455815301756717361332069811250996181881593041690351598888519345807273866738589422879228499892086805825749279610484198444363463244968487560233624827041978623209002160990235304369941849146314093431738143640546253152096183690888707016768396424378140592714563549061303107208510383750510115747704171898610687396965521267154688957035035 0.0)

;>> 6 Pkt

; Teilaufgabe 2.4
;
; Die Annäherungsfunktion für Euler nähert sich so viel schneller an als die für pi, da...
; pi-limit ist auch hier einfach nur zur Begrenzung da, gibt bei diesem Algorithmus jedoch nicht
; zwangsweise die Anzahl nachkommastellen an
; pi-hilf berechnet immer ab einem Glied der Reihe, wobei n immer den jeweiligen Index angibt.
; Der Wert des Gliedes beträgt jeweils 1/(2n+1) entspechend der Vorgabe. Vorzeichen alternierend durch
; Funktion even?.

(define pi-limit 0.1)

(define (pi-hilf n)
  (let ((wert (/ 1 (+ (* 2 n) 1))))
    (cond
      [(<= wert pi-limit) 0]
      [(even? n) (+ wert (pi-hilf (+ n 1)))]
      [else (+ (- wert) (pi-hilf (+ n 1)))])))

(define pi-eigen (* 4 (pi-hilf 0)))

(check-within pi-eigen 3.141 1.0)

;>> 4 Pkt


; Aufgabe 3

(define (type-of obj)
  (cond
    [(boolean? obj) 'boolean]
    [(pair? obj) 'pair]
    [(list? obj) 'list]
    [(symbol? obj) 'symbol]
    [(number? obj) 'number]
    [(char? obj) 'char]
    [(string? obj) 'string]
    [(vector? obj) 'vector]
    [(procedure? obj) 'procedure]))

(define (id z) z)

; 1. (type-of (* 2 3 4)) -> 'number
;    Weil das Ergebnis einer Multiplikation eine Zahl ist?
; 
; 2. (type-of (not 42)) -> 'boolean
;    Funktion gibt #t wenn Param #f, #f ansonsten, also Boolean

;>> Aber 42 scheint #t zu ergeben. Warum?
; 
; 3. (type-of '(eins zwei drei)) -> 'list
;    Weil '() eine Liste erstellt (mit Elementen)
; 
; 4. (type-of '()) -> 'list
;    Siehe letztes
; 
; 5. (type-of (id sin)) -> 'procedure
;    id gibt den Parameter einfach zurück, in diesem Fall sin, was eine Funktion ist
;
; 6. (type-of (string-ref "Harry Potter und der Stein der Weisen" 3)) -> 'char
;    string-ref gibt das Zeichen an einer bestimmten Stelle eines Strings zurück
;
; 7. (type-of (lambda (x) x)) -> 'procedure
;    Mit lamda deklariert man inline eine Funktion, die zurück gegeben wird.
; 
; 8. (type-of type-of) -> 'procedure
;    Dass es auf sich selber angewandt wird, ändert nicht, dass type-of eine procedure ist
; 
; 9. (type-of (type-of type-of)) -> 'symbol
;    type-of gibt immer Symbol zurück

(test)

;>> 5 Pkt
;>> Gesamt: 26 Pkt.