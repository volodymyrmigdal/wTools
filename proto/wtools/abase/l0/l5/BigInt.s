( function _l5_BigInt_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _.bigInt = _.bigInt || Object.create( null );
_.bigInt.s = _.bigInt.s || Object.create( null );

// --
// implementation
// --


function bigIntFrom( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );
  if( _.strIs( src ) )
  return BigInt( src );
  if( _.number.is( src ) )
  return BigInt( src );
  _.assert( _.bigInt.is( src ), 'Cant convert' )
  return src;
}

//

function bigIntsFrom( src )
{
  if( _.number.is( src ) )
  {
    return BigInt( src );
  }
  else if( _.bigInt.is( src ) )
  {
    return src;
  }
  else if( _.longIs( src ) )
  {
    let result = [];
    for( let i = 0 ; i < src.length ; i++ )
    result[ i ] = _.bigInt.from( src[ i ] );
    return result
  }
  else _.assert( 0, 'Cant convert' );
}

//

function exportStringShortCode( src )
{
  _.assert( arguments.length === 1, 'Expects exactly one argument' );
  _.assert( _.bigInt.is( src ) );

  return `${String( src )}n`;
}

// --
// extension
// --

let ExtensionTools =
{
  bigIntFrom,
  bigIntsFrom,
}

//

let Extension =
{
  from : bigIntFrom,

  exportString : exportStringShortCode,
  exportStringShort : exportStringShortCode,
  exportStringShortCode,
  exportStringShortDiagnostic : exportStringShortCode,
  exportStringDiagnostic : exportStringShortCode,
  exportStringCode : exportStringShortCode
}

//

let ExtensionS =
{
  from : bigIntsFrom
}

Object.assign( Self, Extension );
Object.assign( _.bigInt.s, ExtensionS );
Object.assign( _, ExtensionTools );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
