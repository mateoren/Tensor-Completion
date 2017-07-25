--
-- Classify the subsets of entries from which it is possible to complete a 2x2x2 tensor
--



-- function definitions


isThisEntryGood = (I,E) -> (
    
    
  
    newE=append(E,I);
    
    nEparameters=for i to #newE-1 list product for j to d-1 list s_{j+1,newE#i#j};
    
    newRank = rank substitute(jacobian ideal nEparameters ,substituteList);

    newRank == originalRank
    
    )


isThisSubsetGood = E -> (
    
    -- for a subset of entries, yields true if it completes the tensor
    -- also stores the entries completable from E
    
    Eparameters = for i to #E-1 list product for j to d-1 list s_{j+1,E#i#j};
    
    originalRank = rank substitute(jacobian ideal Eparameters, substituteList);
    
    completableEntries = select(for I in last \ baseName \ gens R list (I, isThisEntryGood(I,E)),p -> p#1);
    
    append(compEntriesArchive, completableEntries);
    
    #completableEntries == #indexedEntries
    
    )







printSlicesOriginal=specifiedEntries-> (
    
    
    for i from 1 to lastIndices#2 do M_(i)=mutableMatrix(ZZ,lastIndices#0,lastIndices#1);
    
    for i to #specifiedEntries-1 do M_(specifiedEntries#i#2)_(specifiedEntries#i#0-1,specifiedEntries#i#1-1)=1; -- -1 to the index, starts at 0.
    
    for i from 1 to lastIndices#2 do << M_(i); -- << M_(i) prints the matrix.
    << " - ";
    )    

printSlicesCompletion = completableEntries-> (
    
    -- The input is a list of sequences where each sequence is of the form: ({1,2,1},true)

    for i from 1 to lastIndices#2 do M_(i)=mutableMatrix(ZZ,lastIndices#0,lastIndices#1);
    
    for i to #completableEntries-1 do M_(completableEntries#i#0#2)_(completableEntries#i#0#0-1,completableEntries#i#0#1-1)=1;
    
    for i from 1 to lastIndices#2 do << M_(i);
    << " - ";
    )



-- main program


restart



tSize = (2,3,2);

k = 5; -- # of entries


main  = (tSize, k) -> (
    
    d = #tSize;
    
    firstIndices = {1,1,1};
    
    lastIndices = for i to d-1 list tSize#i;

    -- all entries
    indexedEntries = toList (firstIndices..lastIndices);
    
    -- indexed variables
    listOfParameters = flatten for i from 1 to d list for j from 1 to lastIndices#(i-1) list s_{i,j};

    -- polynomial rings
    R=QQ[p_firstIndices..p_lastIndices];
    S=QQ[listOfParameters];
    
    
    -- give random values to the parameters
    substituteList=for i to #listOfParameters-1 list (flatten entries vars S)_i => random(1,100); 
 
   
    --
    -- Generate all k-subsets and check completability for each one. --
   
    -- k-subsets 
    kSubsets = subsets(indexedEntries, k);
    
    
    -- this is where all the completable entries associated with subsets will be stored
    compEntriesArchive = {};
    
    
    -- k-subsets of entries that complete the whole tensor
    -- Finds the good subsets and the entries that can be completed
    goodSubsets = select(kSubsets, isThisSubsetGood);
    
    -- the complement of goodSubsets
    badSubsets = toList(set(kSubsets)- set(goodSubsets));
    
    
    
    -- missing: 
    
    -- create a sort of dictionary that stores the indices of good and bad subsets in the archive.
        
    
    
    
    
    
    
    
    
    
    )










    
    




   
   









------------------------
-- Ideas to implement --
------------------------

-- Experiment with tensors of different sizes

-- 
 
-----------------------------------
-- cosas que quiero del programa --
-----------------------------------

-- que se puedan implementar diferentes ejemplos facilmente 
-- mas modular, mas logico, bite sized portions
-- more logical choosing of functions
-- visualizacion del resultado, un print statement o una grafica o algo
-- identificar los casos esenciales ...