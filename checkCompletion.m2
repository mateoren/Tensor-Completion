--
-- Compute the subsets of entries that complete the tensor.
--

-- Tip: use := within a function to get local variables.

-----------------------
-- function definitions
-----------------------

isThisEntryGood = (I,E) -> (
    
    newE := append(E,I);
    nEparameters := for i to #newE-1 list product for j to d-1 list s_{j+1,newE#i#j};
    newRank := rank substitute(jacobian ideal nEparameters ,substituteList);
    newRank == originalRank
    
    )

isThisSubsetGood = E -> (
    
    -- for a subset of entries, yields true if it completes the tensor
    -- also stores the entries completable from E
    
    Eparameters = for i to #E-1 list product for j to d-1 list s_{j+1,E#i#j};
    originalRank = rank substitute(jacobian ideal Eparameters, substituteList);
    completableEntries = select(for I in last \ baseName \ gens R list (I, isThisEntryGood(I,E)),p -> p#1);
    
    (if #completableEntries == #indexedEntries then (gCollection = append(gCollection, completableEntries), goodSubsets =  append(goodSubsets,E))
    else if #completableEntries < #indexedEntries then (bCollection = append(bCollection, completableEntries), badSubsets = append(badSubsets, E)));
    
    --#completableEntries == #printSlicesOriginal
    
    )

printSlicesOriginal = specifiedEntries-> (
    
    for i from 1 to lastIndices#2 do M_(i)=mutableMatrix(ZZ,lastIndices#0,lastIndices#1);
    for i to #specifiedEntries-1 do M_(specifiedEntries#i#2)_(specifiedEntries#i#0-1,specifiedEntries#i#1-1)=1; -- -1 to the index, starts at 0.
    for i from 1 to lastIndices#2 do << M_(i); -- << M_(i) prints the matrix.
    
    )    

printSlicesCompletion = completableEntries-> (
    
    -- The input is a list of sequences where each sequence is of the form: ({1,2,1},true)

    for i from 1 to lastIndices#2 do M_(i)=mutableMatrix(ZZ,lastIndices#0,lastIndices#1);
    for i to #completableEntries-1 do M_(completableEntries#i#0#2)_(completableEntries#i#0#0-1,completableEntries#i#0#1-1)=1;
    for i from 1 to lastIndices#2 do << M_(i);
    
    << " - - ";
    
    )
    
---------------    
-- main program
---------------

restart

tSize = (2,3,2);
k = 5; -- # of entries

--main  =  arg -> ( --(tSize, k) -> (
    
    --tSize := arg#0;
    --k := arg#1
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
    substituteList = for i to #listOfParameters-1 list (flatten entries vars S)_i => random(1,100); 
 
    --
    -- Generate all k-subsets and check completability for each one. --
   
    -- k-subsets 
    kSubsets = subsets(indexedEntries, k);
    
    -- subsets of entries that can complete the tensor
    goodSubsets = {};
    
    -- subsets of entries that don't fully complete the tensor
    badSubsets = {};
   
    -- this is where all the completable entries associated with good subsets will be stored
    gCollection = {};
    
    -- the analog for bad subsets 
    bCollection = {};
    
    for E in kSubsets do isThisSubsetGood(E);
       
  -- )

--main(tSize,k);

--printSlicesOriginal(goodSubsets#503)
--printSlicesCompletion(goodArchive#503)

printSlicesOriginal(badSubsets#200)
printSlicesCompletion(bCollection#200)

<< "         ";

printSlicesOriginal(badSubsets#0)
printSlicesCompletion(bCollection#0)
 
