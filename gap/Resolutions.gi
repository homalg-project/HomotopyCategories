

##
InstallOtherMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject ],
  function( a )
    
    return ProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a );
    
end );

##
InstallOtherMethod( ProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
  function( a, bool )
    
    return ProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a );
    
end );

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject ],
  function( a )
    
    return QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a );
    
end );

##
InstallOtherMethod( QuasiIsomorphismFromProjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
  function( a, bool )
    
    return QuasiIsomorphismFromProjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a );
    
end );

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
  function( alpha )
    
    return MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha );
    
end );

##
InstallOtherMethod( MorphismBetweenProjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
  function( alpha, bool )
    
    return MorphismBetweenProjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha );
    
end );

##
InstallOtherMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject ],
  function( a )
    
    return InjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a );
    
end );

##
InstallOtherMethod( InjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
  function( a, bool )
    
    return InjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a );
    
end );

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism ],
  function( alpha )
    
    return MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ) ) / CapCategory( alpha );
    
end );

##
InstallOtherMethod( MorphismBetweenInjectiveResolutions,
          [ IsHomotopyCategoryMorphism, IsBool ],
  function( alpha, bool )
    
    return MorphismBetweenInjectiveResolutions( UnderlyingCell( alpha ), bool ) / CapCategory( alpha );
    
end );

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject ],
  function( a )
    
    return QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ) ) / CapCategory( a );
    
end );

##
InstallOtherMethod( QuasiIsomorphismIntoInjectiveResolution,
          [ IsHomotopyCategoryObject, IsBool ],
  function( a, bool )
    
    return QuasiIsomorphismIntoInjectiveResolution( UnderlyingCell( a ), bool ) / CapCategory( a );
    
end );

