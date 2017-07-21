restart

d = 3;

k = 4;

indexedEntries = toList ({1,1,1}..{2,2,2});

kSubsets = subsets(indexedEntries, k);

        
firstIndices = {1,1,1};

lastIndices = {2,2,2};

    
listOfParameters = flatten for i from 1 to d list for j from 1 to lastIndices#(i-1) list s_{i,j};
    

R=QQ[p_firstIndices..p_lastIndices];

S=QQ[listOfParameters];
    

substituteList=for i to #listOfParameters-1 list (flatten entries vars S)_i => random(1,100);


   
   
-- This function should take 2 parameters: I and E (where E = specifiedIndices)
   
isThisEntryGood = (I,E) -> (
  
    newE=append(E,I);
    
    nEparameters=for i to #newE-1 list product for j to d-1 list s_{j+1,newE#i#j};
    
    newRank = rank substitute(jacobian ideal nEparameters ,substituteList);

    newRank == originalRank
    
    )
    
    
verifyCompletability = E -> (
    
    d=3;
    
    Eparameters = for i to #E-1 list product for j to d-1 list s_{j+1,E#i#j};
    
    originalRank = rank substitute(jacobian ideal Eparameters, substituteList);
    
    completableEntries = select(for I in last \ baseName \ gens R list (I, isThisEntryGood(I,E)),p -> p#1);
    
    
    
    #completableEntries == 8
    
    )



    
    
goodSubsets = select(kSubsets, verifyCompletability);

a =  select(for I in last \ baseName \ gens R list (I, isThisEntryGood(I,goodSubsets#0)),p -> p#1);

completed = for E in goodSubsets list select(for I in last \ baseName \ gens R list (I, isThisEntryGood(I,E)),p -> p#1);



printSlicesOriginal=specifiedEntries-> (
    
    
    for i from 1 to lastIndices#2 do M_(i)=mutableMatrix(ZZ,lastIndices#0,lastIndices#1);
    
    for i to #specifiedEntries-1 do M_(specifiedEntries#i#2)_(specifiedEntries#i#0-1,specifiedEntries#i#1-1)=1; -- -1 to the index, starts at 0.
    
    for i from 1 to lastIndices#2 do << M_(i); -- << M_(i) prints the matrix
    << " -- ";
    )    

printSlicesCompletion = completableEntries-> (
    
    -- The input is a list of sequences where each sequence is of the form: ({1,2,1},true)

    for i from 1 to lastIndices#2 do M_(i)=mutableMatrix(ZZ,lastIndices#0,lastIndices#1);
    
    for i to #completableEntries-1 do M_(completableEntries#i#0#2)_(completableEntries#i#0#0-1,completableEntries#i#0#1-1)=1;
    
    for i from 1 to lastIndices#2 do << M_(i);
    << " -- ";
    )


