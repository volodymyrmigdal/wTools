( function _Diagnostic_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer1.s' );
  _.include( 'wTesting' );
}

let _ = _global_.wTools;

//--
// tests
//--

function structureGenerate( test )
{

  test.case = 'implicity call';
  var got = _.diagnostic.structureGenerate();
  test.true( _.mapIs( got.result ) );
  test.identical( got.result[ 'number.big' ], 1 << 30 );
  test.true( _.number.is( got.size ) );

  test.case = 'defaultComplexity : 5, depth : 3';
  var got = _.diagnostic.structureGenerate({ defaultComplexity : 5, depth : 3 });
  test.true( _.mapIs( got.result ) );
  test.true( _.hashMap.is( got.result.hashmap ) );
  test.true( _.set.is( got.result.set ) );

}

structureGenerate.timeOut = 50000;

// --
//
// --

let Self =
{

  name : 'Tools.Diagnostic',
  silencing : 1,
  enabled : 1,

  tests :
  {
    structureGenerate,
  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
