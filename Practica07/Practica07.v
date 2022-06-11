(*
%%%%%%%%%%%%%%%%%%%%%%%%% Integrantes %%%%%%%%%%%%%%%%%%%%%%%%%
*** Adrian Aguilera Moreno: 421005200.
*** Marco Silva Huerta: 316205326.
*)

Require Import Setoid.
Section Practica07.

  (**************************************** NATURALES ****************************************)
  Inductive naturales : Type := | cero : naturales | Suc : naturales -> naturales.
  (******************************************** 1 ********************************************)
  (* Definiendo la suma. *)
  Fixpoint suma (x : naturales) (y : naturales) : naturales :=
    match x with
    | cero => y
    | Suc(v) => Suc(suma v m)
    end.
  
  Notation "x + y" := (suma x y).

  (* Definiendo el producto *)
  Fixpoint producto (x : naturales) (y : naturales) : naturales :=
    match x with
    | cero => y 
    | Suc(v) => Suc(producto v y)
    end.
  
  Notation "x * y" := (producto x y).
  
  (******************************************** 2 ********************************************)
  (* Axiomas *)
  Hypothesis suma_neutral_derecha:       forall n   : naturales, n + cero = n.                   (* Neutro en la suma. *)
  Hypothesis producto_colapso_derecha:   forall n   : naturales, n * cero = cero.                (* Colapso del producto a 0. *)
  Hypothesis producto_colapso_izquierda: forall n   : naturales, cero * n = cero.                (* Colapso del producto a 0. *)
  Hypothesis producto_suc_izquierda :    forall a b : naturales, a*Suc(b) = a*b+a.               (* Producto del sucesor de un número. *)
  Hypothesis producto_suc_derecha :      forall a b : naturales, a*b+a    = a*Suc(b).            (* Producto del sucesor de un número. *)
  
  (* Demostrando que la suma es asociativa. *)
  Theorem aux_suma_asociativa: forall n m r : naturales, n + (m + r) = (n + m) + r.
  Proof.
    intros.
    induction n as [|n' IHn'].
    - reflexivity.
    - simpl.
      rewrite IHn'.
      reflexivity.
  Qed.
  
  (* Demostrando distributividad del producto frente a la suma. *)
  Theorem distributividad_producto: forall n m r : naturales, n*(m+r) = (n * m) + (n * r).
  Proof.
    intros.
    induction r as [|r' HIn']. 
    - rewrite suma_neutral_derecha.
      rewrite producto_colapso_derecha.
      rewrite suma_neutral_derecha.
      reflexivity.
    - rewrite adicion.  
      rewrite producto_suc_izquierda.        
      rewrite HIn'.
      rewrite <- aux_suma_asociativa.
      rewrite producto_suc_derecha.  
      reflexivity.
  Qed.
  
  (******************************************** 3 ********************************************)
 
 (******************************************** 5 ********************************************)
  
Theorem cinco: forall p q r s t u: Prop,(p->q->r)/\ (p\/s)/\(t->q)/\(~s)->~r->~t.
Proof.
  intros.
  destruct H.
  destruct H1.
  destruct H2.
  intro.
  apply H2 in H4.
  apply H in H4.
  contradiction.
  destruct(classic p).
  apply H in H4.
  contradiction.
  apply H5.
  destruct H1.
  contradiction.
  contradiction.
Qed.

 (******************************************** 5 ********************************************)
