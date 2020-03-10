#####################################################################
#
#   HomotopyCategories.gi                   Homotopy Categories
#                                           Siegen University
#   2020                                    Kamal Saleh
#
#####################################################################

BindGlobal( "ADD_TRIANGULATED_STRUCUTRE",

function( Ho_C )
    
  SetIsTriangulatedCategory( Ho_C, true );
  
  SetIsTriangulatedCategoryWithShiftAutomorphism( Ho_C, true );

  ## Adding the shift and reverse shift functors
  AddShiftOfObject( Ho_C,
    function( C )
      local twist_functor;
      
      twist_functor := ShiftFunctor( Ho_C, -1 );
    
      return ApplyFunctor( twist_functor, C );
      
  end );

  ##
  AddShiftOfMorphism( Ho_C, 
      function( phi )
        local twist_functor;
        
        twist_functor := ShiftFunctor( Ho_C, -1 );
  
      return ApplyFunctor( twist_functor, phi );
  
  end );
  
  ##
  AddReverseShiftOfObject( Ho_C,
      function( C )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, 1 );
   
        return ApplyFunctor( reverse_twist_functor, C );
  
  end );
  
  ##
  AddReverseShiftOfMorphism( Ho_C,
      function( phi )
        local reverse_twist_functor;
        
        reverse_twist_functor := ShiftFunctor( Ho_C, 1 );
      
        return ApplyFunctor( reverse_twist_functor, phi );
  
  end );
  
  ##
  AddIsomorphismIntoShiftOfReverseShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismFromShiftOfReverseShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismIntoReverseShiftOfShift( Ho_C, IdentityMorphism );
  
  AddIsomorphismFromReverseShiftOfShift( Ho_C, IdentityMorphism );
  
  AddConeObject( Ho_C, MappingCone );
  
  AddMorphismIntoConeObjectWithGivenConeObject( Ho_C,
    function( phi, C )
      local cell;
      
      cell := UnderlyingCell( phi );
      
      return NaturalInjectionInMappingCone( cell ) / Ho_C;
      
  end );
  
  AddMorphismFromConeObjectWithGivenConeObject( Ho_C,
    function( phi, C )
      local cell;
      
      cell := UnderlyingCell( phi );
      
      return NaturalProjectionFromMappingCone( cell ) / Ho_C;
      
  end );
 
  ##
  AddCompleteMorphismToStandardExactTriangle( Ho_C,
      function( phi )
        local i, p;
        
        i := NaturalInjectionInMappingCone( phi );
        
        p := NaturalProjectionFromMappingCone( phi );
        
        return CreateStandardExactTriangle( phi, i, p );
      
  end );
  
  ##
  AddCompleteToMorphismOfStandardExactTriangles( Ho_C,
      function( tr1, tr2, phi, psi )
        local tr1_0, tr2_0, phi_, psi_, homotopy_maps, maps, tau;
        
        tr1_0 := UnderlyingCell( tr1^0 );
        
        tr2_0 := UnderlyingCell( tr2^0 );
        
        phi_ := UnderlyingCell( phi );
        
        psi_ := UnderlyingCell( psi );
        
        homotopy_maps := HomotopyMorphisms( PreCompose( tr1^0, psi ) - PreCompose( phi, tr2^0 ) );
        
        maps := MapLazy( IntegersList,
                  function( i )
                    return
                      MorphismBetweenDirectSums(
                        [
                          [ phi_[ i - 1 ], homotopy_maps[ i - 1 ] ],
                          [ ZeroMorphism( Source( psi_ )[ i ], Range( phi_ )[ i - 1 ] ), psi_[ i ] ]
                        ] );
                  end, 1 );
        
        tau := ChainMorphism( 
                UnderlyingCell( tr1[2] ), 
                UnderlyingCell( tr2[2] ),
                maps );
        
        tau := HomotopyCategoryMorphism( Ho_C, tau );
        
        return CreateTrianglesMorphism( tr1, tr2, phi, psi, tau );
  end );
  
  ##
  AddRotationOfStandardExactTriangle( Ho_C,
      function( T )
        local rotation, st_rotation, phi, A, B, maps, tau;
      
        rotation := CreateExactTriangle( T ^ 1, T ^ 2, AdditiveInverse( ShiftOfMorphism( T ^ 0 ) ) );
      
        st_rotation := CompleteMorphismToStandardExactTriangle( rotation ^ 0 );
      
        phi := UnderlyingCell( T ^ 0 );
      
        A := UnderlyingCell( T[ 0 ] );
      
        B := UnderlyingCell( T[ 1 ] );
      
        maps := MapLazy( IntegersList,  
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [
                        AdditiveInverse( phi[ i - 1 ] ),
                        IdentityMorphism( A[ i - 1 ] ),
                        ZeroMorphism( A[ i - 1 ], B[ i ] )
                      ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
                  UnderlyingCell( rotation[ 2 ] ),
                    UnderlyingCell( st_rotation[ 2 ] ), maps
                  );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  rotation, st_rotation, IdentityMorphism( T[ 1 ] ), IdentityMorphism( T[ 2 ] ), tau );
      
        SetIsomorphismIntoStandardExactTriangle( rotation, tau );
      
        maps := MapLazy( IntegersList,
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( B[ i - 1 ], A[ i - 1 ] ) ],
                      [ IdentityMorphism( A[ i - 1 ] ) ],
                      [ ZeroMorphism( B[ i ], A[ i - 1 ] ) ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
                UnderlyingCell( st_rotation[ 2 ] ),
                  UnderlyingCell( rotation[ 2 ] ), maps
                );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  st_rotation, rotation, IdentityMorphism( T[ 1 ] ), IdentityMorphism( T[ 2 ] ), tau );
      
        SetIsomorphismFromStandardExactTriangle( rotation, tau );
      
        return rotation;
        
  end );
  
  ##
  AddReverseRotationOfStandardExactTriangle( Ho_C,
      function( T )
        local rotation, st_rotation, phi, A, B, maps, tau;
      
        rotation := CreateExactTriangle( AdditiveInverse( Shift( T ^ 2, -1 ) ), T ^ 0, T ^ 1 );
      
        st_rotation := CompleteMorphismToStandardExactTriangle( rotation ^ 0 );
      
        phi := UnderlyingCell( T ^ 0 );
      
        A := UnderlyingCell( T[ 0 ] );
      
        B := UnderlyingCell( T[ 1 ] );
      
        maps := MapLazy( IntegersList,  
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ ZeroMorphism( A[ i - 1 ], B[ i ] ) ],
                      [ IdentityMorphism( B[ i ] ) ],
                      [ phi[ i ] ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism( 
                UnderlyingCell( st_rotation[ 2 ] ),
                  UnderlyingCell( rotation[ 2 ] ),
                    maps );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  st_rotation, rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), tau );
      
        SetIsomorphismFromStandardExactTriangle( rotation, tau );
      
        maps := MapLazy( IntegersList,
                function( i )
                  return
                  MorphismBetweenDirectSums(
                    [ 
                      [ 
                        ZeroMorphism( B[ i ], A[ i - 1 ] ),
                        IdentityMorphism( B[ i ] ),
                        ZeroMorphism( B[ i ], A[ i ] )
                      ]
                    ] );
                end, 1 );
      
        tau := ChainMorphism(
                  UnderlyingCell( rotation[ 2 ] ), 
                  UnderlyingCell( st_rotation[ 2 ] ),
                  maps );
      
        tau := HomotopyCategoryMorphism( CapCategory( T ^ 0 ), tau );
      
        tau := CreateTrianglesMorphism(
                  rotation, st_rotation, IdentityMorphism( rotation[ 0 ] ), IdentityMorphism( rotation[ 1 ] ), tau );
      
        SetIsomorphismIntoStandardExactTriangle( rotation, tau );
      
        return rotation;
        
  end );

  AddOctahedralAxiom( Ho_C,
    function( f, g )
      local Ho_C, A, B, C, h, cone_f, cone_g, cone_h, shifted_cone_f, u, v, w, T, st_T, maps, cone_u, i, j;
      
      Ho_C := CapCategory( f );
      
      A := UnderlyingCell( Source( f ) );
      
      B := UnderlyingCell( Range( f ) );
      
      C := UnderlyingCell( Range( g ) );
      
      h := PreCompose( f, g );
      
      cone_f := UnderlyingCell( ConeObject( f ) );
      
      cone_g := UnderlyingCell( ConeObject( g ) );
      
      cone_h := UnderlyingCell( ConeObject( h ) );
      
      shifted_cone_f := UnderlyingCell( ShiftOfObject( ConeObject( f ) ) );
      
      u := MapLazy( IntegersList,
            n -> MorphismBetweenDirectSums(
                  [
                    [ IdentityMorphism( A[ n - 1 ]  )   , ZeroMorphism( A[ n - 1 ], C[ n ] ) ],
                    [ ZeroMorphism( B[ n ], A[ n - 1 ] ), g[ n ]                             ],
                  ]
                ), 1 );
      
      u := ChainMorphism( cone_f, cone_h, u ) / Ho_C;
      
      v := MapLazy( IntegersList,
            n -> MorphismBetweenDirectSums(
                  [
                    [ f[ n - 1 ], ZeroMorphism( A[ n - 1 ], C[ n ] ) ],
                    [ ZeroMorphism( C[ n ], B[ n - 1 ] ), IdentityMorphism( C[ n ] ) ],
                  ]
                ), 1 );
      
      v := ChainMorphism( cone_h, cone_g, v ) / Ho_C;
      
      w := MapLazy( IntegersList,
            n -> MorphismBetweenDirectSums(
                  [
                    [ ZeroMorphism( B[ n - 1 ], A[ n - 2 ] ), IdentityMorphism( B[ n - 1 ] ) ],
                    [ ZeroMorphism( C[ n ], A[ n - 2 ]  ), ZeroMorphism( C[ n ], B[ n - 1 ] ) ],
                  ]
                ), 1 );
      
      w := ChainMorphism( cone_g, shifted_cone_f, w ) / Ho_C;
      
      T := CreateExactTriangle( u, v, w );
      
      st_T := CompleteMorphismToStandardExactTriangle( u );
      
      maps := MapLazy( IntegersList,
            n -> MorphismBetweenDirectSums(
                  [  
                    [ ZeroMorphism( B[ n - 1 ], A[ n - 2 ] ), IdentityMorphism( B[ n - 1 ] )    , ZeroMorphism( B[ n - 1 ], A[ n - 1 ] ), ZeroMorphism( B[ n - 1 ], C[ n ] )  ],
                    [ ZeroMorphism( C[ n ] , A[ n - 2 ] )   , ZeroMorphism( C[ n ], B[ n - 1 ] ), ZeroMorphism( C[ n ], A[ n - 1 ] )    , IdentityMorphism( C[ n ] )          ]
                  ]
              ), 1 );
      
      cone_u := UnderlyingCell( ConeObject( u ) );
      
      i := ChainMorphism( cone_g, cone_u, maps ) / Ho_C;
      
      i := CreateTrianglesMorphism( T, st_T, IdentityMorphism( cone_f ) / Ho_C, IdentityMorphism( cone_h ) / Ho_C, i );
      
      SetIsomorphismIntoStandardExactTriangle( T, i );
      
      maps := MapLazy( IntegersList,
            n -> MorphismBetweenDirectSums(
                  [  
                    [ ZeroMorphism( A[ n - 2 ] , B[ n - 1 ] ), ZeroMorphism( A[ n - 2 ] ,C[ n ] ) ],
                    [ IdentityMorphism( B[ n - 1 ] )         , ZeroMorphism( B[ n -1 ], C[ n ] )  ],
                    [ f[ n - 1 ], ZeroMorphism( A[ n - 1 ]   , C[ n ] )                           ],
                    [ ZeroMorphism( C[ n ], B[ n - 1 ] )     , IdentityMorphism( C[ n ] )         ]
                  ]
              ), 1 );
      
      j := ChainMorphism( cone_u, cone_g, maps ) / Ho_C;
      
      j := CreateTrianglesMorphism( st_T, T, IdentityMorphism( cone_f ) / Ho_C, IdentityMorphism( cone_h ) / Ho_C, j );
      
      SetIsomorphismFromStandardExactTriangle( T, j );
     
      return T;
      
  end );

end );

