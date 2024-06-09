------------------------------------------------------------------------
-- The Agda standard library
--
-- Consequences of a monomorphism between modules
------------------------------------------------------------------------

{-# OPTIONS --safe --cubical-compatible #-}

open import Algebra.Module.Bundles.Raw
open import Algebra.Module.Morphism.Structures

module Algebra.Module.Morphism.ModuleMonomorphism
  {r a b ℓ₁ ℓ₂} {R : Set r} {M : RawModule R a ℓ₁} {N : RawModule R b ℓ₂} {⟦_⟧}
  (isModuleMonomorphism : IsModuleMonomorphism M N ⟦_⟧)
  where

open IsModuleMonomorphism isModuleMonomorphism
private
  module M = RawModule M
  module N = RawModule N

open import Algebra.Bundles
open import Algebra.Core
open import Algebra.Module.Structures
open import Algebra.Structures
open import Relation.Binary.Core

------------------------------------------------------------------------
-- Re-exports

open import Algebra.Module.Morphism.BimoduleMonomorphism isBimoduleMonomorphism public
open import Algebra.Module.Morphism.SemimoduleMonomorphism isSemimoduleMonomorphism public
  using (*ₗ-*ᵣ-coincident; isSemimodule)

------------------------------------------------------------------------
-- Structures

isModule :
  ∀ {ℓr} {_≈_ : Rel R ℓr} {_+_ _*_ : Op₂ R} { -_ : Op₁ R} {0# 1# : R}
  (R-isCommutativeRing : IsCommutativeRing _≈_ _+_ _*_ -_ 0# 1#)
  (let R-commutativeRing = record { isCommutativeRing = R-isCommutativeRing })
  → IsModule R-commutativeRing N._≈ᴹ_ N._+ᴹ_ N.0ᴹ N.-ᴹ_ N._*ₗ_ N._*ᵣ_
  → IsModule R-commutativeRing M._≈ᴹ_ M._+ᴹ_ M.0ᴹ M.-ᴹ_ M._*ₗ_ M._*ᵣ_
isModule R-isCommutativeRing isModule = record
  { isBimodule = isBimodule R.isRing R.isRing NN.isBimodule
  ; *ₗ-*ᵣ-coincident = *ₗ-*ᵣ-coincident NN.+ᴹ-isMagma NN.*ₗ-*ᵣ-coincident
  }
  where
    module R = IsCommutativeRing R-isCommutativeRing
    module NN = IsModule isModule
