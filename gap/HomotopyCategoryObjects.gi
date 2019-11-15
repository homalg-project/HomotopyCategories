

##
DeclareRepresentation( "IsHomotopyCategoryObjectRep",
                       IsCapCategoryObjectRep and IsHomotopyCategoryObject,
                       [ ] );

##
BindGlobal( "TheTypeOfHomotopyCategoryObject",
        NewType( TheFamilyOfCapCategoryObjects,
                IsHomotopyCategoryObjectRep ) );

##
InstallMethod( HomotopyCategoryObject,
            [ IsHomotopyCategory, IsCapCategoryObject ],
            
  function( homotopy_category, a )
    local homotopy_a;
    
    if not IsIdenticalObj( UnderlyingCapCategory( homotopy_category ), CapCategory( a ) ) then
      
      Error( "The input is not compatible!\n" );
      
    fi;
    
    homotopy_a := StableCategoryObject( homotopy_category, a );
    
    SetFilterObj( homotopy_a, IsHomotopyCategoryObject );
     
    return homotopy_a;
    
end );

##
InstallMethod( \/,
          [ IsCapCategoryObject, IsHomotopyCategory ],
  {a,H} -> HomotopyCategoryObject( H, a )
);


##
InstallMethod( Display,
            [ IsHomotopyCategoryObject ],
  function( a )
  
    Print( "An object in homotopy category defined by:\n\n" );

    Display( ChainComplex( a ) );

end );

InstallMethod( ViewObj,
            [ IsHomotopyCategoryObject ],
  function( a )
    
    Print( "<An object in homotopy category defined by: " );

    ViewObj( UnderlyingCell( a ) );
    
    Print(">" );

end );
 
