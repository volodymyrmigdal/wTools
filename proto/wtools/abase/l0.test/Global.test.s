( function _Global_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer1.s' );
  _.include( 'wTesting' );
}

let _global = _global_;
let _ = _global_.wTools;

// --
// tests
// --

function checks( test ) /* qqq for Yevhen : enable and extend ( file Global.test.s ) */
{

  /* */

  test.case = 'primitive - string';
  var src = 'str';
  test.true( !_.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = 'primitive - number';
  var src = 1;
  test.true( !_.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = 'primitive - bool';
  var src = true;
  test.true( !_.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = 'map';
  var src = Object.create( null );
  test.true( !_.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = 'object';
  var src = { global : true };
  test.true( !_.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = 'namespace';
  var src = _.entity;
  test.true( !_.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  /* */

  test.case = 'current global';
  var src = _global_;
  test.true( _.global.is( src ) );
  test.true( _.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = 'global';
  var src = global;
  test.true( _.global.is( src ) );
  test.true( _.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  test.case = '_realGlobal_';
  var src = _realGlobal_;
  test.true( _.global.is( src ) );
  test.true( _.global.isReal( src ) );
  test.true( !_.global.isDerivative( src ) );

  /* */

  test.case = 'current global in prototype';
  var src = Object.create( _global_ );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = 'global in prototype';
  var src = Object.create( global );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = '_realGlobal_ in prototype';
  var src = Object.create( _realGlobal_ );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  /* */

  test.case = 'current global in prototype, 2 level of nesting';
  var src = Object.create( _global_ );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = 'global in prototype, 2 level of nesting';
  var src = Object.create( global );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = '_realGlobal_ in prototype, 2 level of nesting';
  var src = Object.create( _realGlobal_ );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  /* */

  test.case = 'current global in prototype, 3 level of nesting';
  var src = Object.create( _global_ );
  src = Object.create( src );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = 'global in prototype, 3 level of nesting';
  var src = Object.create( global );
  src = Object.create( src );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = '_realGlobal_ in prototype, 3 level of nesting';
  var src = Object.create( _realGlobal_ );
  src = Object.create( src );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  /* */

  test.case = 'current global in prototype, 5 level of nesting';
  var src = Object.create( _global_ );
  src = Object.create( src );
  src = Object.create( src );
  src = Object.create( src );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = 'global in prototype, 5 level of nesting';
  var src = Object.create( global );
  src = Object.create( src );
  src = Object.create( src );
  src = Object.create( src );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );

  test.case = '_realGlobal_ in prototype, 5 level of nesting';
  var src = Object.create( _realGlobal_ );
  src = Object.create( src );
  src = Object.create( src );
  src = Object.create( src );
  src = Object.create( src );
  test.true( _.global.is( src ) );
  test.true( !_.global.isReal( src ) );
  test.true( _.global.isDerivative( src ) );
}

// --
// declaration
// --

var Self =
{

  name : 'Tools.Global',
  silencing : 1,

  tests :
  {

    checks,

  }

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
