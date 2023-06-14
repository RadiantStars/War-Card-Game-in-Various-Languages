module Main where
    import Test.HUnit
    import qualified War
    import qualified System.Exit as Exit

    main = do
         status <- runTestTT tests
         if failures status > 0 then Exit.exitFailure else return ()
-- run tests with:
--     cabal test

-- here are some standard tests
-- you should augment them with your own tests for development purposes

    deal = War.deal

    tests = test [
      "test1" ~: deal [8, 6, 8, 4, 12, 5, 10, 7, 11, 10, 11, 9, 10, 6, 1, 1, 9, 1, 2, 12, 4, 5, 2, 11, 3, 9, 7, 11, 3, 3, 9, 2, 4, 5, 8, 13, 6, 6, 10, 3, 8, 12, 13, 7, 5, 7, 12, 13, 1, 4, 2, 13] ~=? [8,4,1,11,1,2,9,8,11,9,10,4,10,7,6,2,12,7,8,7,1,5,9,3,12,3,7,2,13,12,13,10,13,10,5,5,4,3,1,6,6,6,4,2,13,11,11,9,8,3,12,5],
      "test2" ~: deal [9, 10, 2, 10, 12, 8, 7, 4, 3, 6, 10, 11, 10, 7, 3, 2, 13, 5, 2, 6, 6, 7, 1, 7, 8, 5, 3, 13, 9, 11, 5, 9, 13, 12, 12, 6, 5, 2, 1, 13, 1, 1, 9, 4, 8, 11, 3, 4, 4, 11, 12, 8] ~=? [5,3,4,2,13,8,12,4,12,6,10,3,8,5,7,2,6,3,4,2,1,12,13,11,11,9,9,4,10,7,1,11,11,5,9,3,1,9,13,7,8,6,6,5,1,10,12,7,13,10,8,2],
      "test3" ~: deal [11, 5, 10, 13, 6, 6, 2, 13, 1, 10, 5, 13, 2, 4, 4, 9, 11, 6, 7, 8, 8, 8, 3, 5, 9, 2, 8, 10, 1, 12, 7, 11, 3, 4, 1, 7, 13, 3, 9, 9, 4, 2, 6, 12, 12, 1, 3, 7, 11, 12, 5, 10] ~=? [8,5,1,8,7,5,10,8,7,2,12,6,10,4,13,3,13,2,11,10,1,9,1,7,1,6,12,3,12,4,11,3,12,9,4,3,11,4,13,13,9,6,2,2,11,9,10,5,8,7,6,5],
      "test4" ~: deal [1, 1, 11, 10, 2, 13, 13, 2, 9, 10, 12, 13, 12, 7, 4, 13, 9, 12, 6, 4, 11, 1, 8, 7, 4, 5, 9, 6, 5, 3, 12, 10, 8, 3, 7, 8, 4, 8, 9, 2, 2, 10, 7, 3, 6, 11, 6, 3, 5, 11, 1, 5] ~=? [5,4,12,8,9,6,13,8,8,6,6,5,13,8,6,5,12,7,4,3,7,4,1,4,13,2,13,12,1,12,10,9,1,10,11,11,11,11,10,2,9,3,10,2,5,2,1,9,7,7,3,3],
      "test5" ~: deal [9, 7, 11, 8, 6, 13, 11, 9, 10, 8, 6, 1, 6, 6, 8, 7, 5, 1, 10, 13, 12, 7, 3, 12, 8, 4, 12, 3, 4, 1, 7, 13, 2, 12, 1, 5, 4, 13, 3, 4, 2, 10, 11, 3, 9, 9, 2, 11, 5, 5, 10, 2] ~=? [9,3,1,9,12,5,13,6,7,5,13,7,9,2,1,3,13,2,1,12,12,8,10,5,11,10,13,4,11,4,11,3,6,2,11,8,8,7,9,8,1,5,10,4,10,4,6,3,12,6,7,2]

      ]