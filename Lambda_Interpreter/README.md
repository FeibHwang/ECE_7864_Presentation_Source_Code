# ECE_7864_Presentation_Source_Code
Source code for the presentation


Basic Command
---
zero = \f.\x.x 
succ = \n.\f.\x.f (n f x) 
plus = \m.\n.m succ n 
mult = \m.\n.\f.m (n f) 
pow = \b.\e.e b 
pred = \n.\f.\x.n (\g.\h.h (g f)) (\u.x) (\u.u) 
sub = \m.\n.n pred m 
one = succ zero 
two = succ one 
three = succ two 
four = succ three 
true = \x.\y.x 
false = \x.\y.y 
and = \p.\q.p q p 
or = \p.\q.p p q 
not = \p.\a.\b.p b a 
if = \p.\a.\b.p a b 
iszero = \n.n (\x.false) true 
leq = \m.\n.iszero (sub m n) 
eq = \m.\n. and (leq m n) (leq n m) 
Y = \g.(\x.g (x x)) (\x.g (x x))