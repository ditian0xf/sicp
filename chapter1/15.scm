;-----
;1.15
;-----
; a. 5 times. log_(3)_(12.5 / 0.1) = 4.37.
; b. Time complexity: O(log_(3)_(a / 0.1)) --> O(lg(a)).
;    Space complexity: 
;      (sine 12.15)
;      (p (sine 4.05))  --------------------- (1)
;      (p (p (sine 1.35)))  ----------------- (2)
;      (p (p (p (sine 0.45))))  ------------- (3)
;      (p (p (p (p (sine 0.15)))))  --------- (4)
;      (p (p (p (p (p (sine 0.05))))))  ----- (5)
;
;      (p (p (p (p (p 0.05)))))  ------------ (6)
;      (p (p (p (p 0.1495))))  -------------- (7)
;      (p (p (p 0.4351345505)))  ------------ (8)
;      (p (p 0.9758465331678772))  ---------- (9)
;      (p -0.7895631144708228)  ------------- (10)
;      -0.39980345741334
;        We can see that there is "expansion then contraction".
;        (1) - (5) are all deferred evaluations (as regards function p).
;        (6) - (10) are the steps where actual evaluations happen.
;        Therefore this is a recursive process.
;        The space complexity is therefore O(lg(a)).
