# Tensor Completion

This Macaulay2 code implements a function that decides whether an input in the form of a partial tensor is completable to a rank-one tensor. Furthermore, for a given positive integer k it generates all the partial tensors of a specified size *(mxnxk)* having *k* known entries and decides which tensors are completable to rank-one.

## Motivation

The article *"The Geometry of Rank-One Tensor Completion"* by T. Kahle, K. Kubjas, M. Kummer and Z. Rosen describes a method for deciding the completability of a partial tensor by checking the rank of a certain matroid. Since the methods described rely on algebro-geometric computations, the Macaulay2 language is the appropriate choice. 

This code is part of my master's thesis work.

## Usage

It suffices to define a tensor size as a tuple *(m,n,k)*, and a positive integer *k*. The script will generate all partial tensors of given size and given number of entries, classifying them as completable or non-completable.

## Author

Mateo Rendón Jaramillo.

