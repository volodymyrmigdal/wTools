( function _Container_test_s_()
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

function is( test )
{

  test.case = 'not';
  test.identical( _.container.is( null ), false );
  test.identical( _.container.is( undefined ), false );
  test.identical( _.container.is( 'str' ), false );
  test.identical( _.container.is( 0 ), false );
  test.identical( _.container.is( 1 ), false );
  test.identical( _.container.is( false ), false );
  test.identical( _.container.is( true ), false );
  test.identical( _.container.is( new Date() ), false );

  test.case = 'map';
  test.identical( _.container.is( {} ), true );
  test.identical( _.container.is( { a : 1 } ), true );
  test.identical( _.container.is( Object.create( null ) ), true );

  test.case = 'instance';
  let src = new function Con() { this.a = 1 };
  test.identical( _.container.is( src ), false );

  test.case = 'hashmap';
  test.identical( _.container.is( new HashMap ), true );
  test.identical( _.container.is( new HashMap([ [ 'a', 'b' ] ]) ), true );

  test.case = 'array';
  test.identical( _.container.is( [] ), true );
  test.identical( _.container.is( [ false ] ), true );

  test.case = 'typed buffer';
  test.identical( _.container.is( new F32x() ), true );
  test.identical( _.container.is( new F32x([ 1, 2, 3 ]) ), true );

  test.case = 'set';
  test.identical( _.container.is( new Set ), true );
  test.identical( _.container.is( new Set([ 'a', 'b' ]) ), true );

}

//

function like( test )
{

  test.case = 'number';
  var src = 1;
  test.true( !_.container.like( src ) );

  test.case = 'bool & boolLike & fuzzy';
  var src = true;
  test.true( !_.container.like( src ) );

  test.case = 'boolLike & number & fuzzyLike';
  var src = 1;
  test.true( !_.container.like( src ) );

  test.case = 'fuzzy';
  var src = _.maybe;
  test.true( !_.container.like( src ) );

  test.case = 'bigint';
  var src = 10n;
  test.true( !_.container.like( src ) );

  test.case = 'str & regexpLike';
  var src = 'str';
  test.true( !_.container.like( src ) );

  test.case = 'regexp & objectLike & constructible & constructibleLike';
  var src = /hello/g;
  test.true( _.container.like( src ) );

  test.case = 'ArgumentsArray & arrayLike';
  var src = _.argumentsArray.make();
  test.true( _.container.like( src ) );

  test.case = 'unroll';
  var src = _.unrollMake([ 2, 3, 4 ]);
  test.true( _.container.like( src ) );

  test.case = 'array';
  var src = [ 2, 3, 4 ];
  test.true( _.container.like( src ) );

  test.case = 'long & longLike';
  var src = _.longMake([ 1, 2 ]);
  test.true( _.container.like( src ) );

  test.case = 'vector & vectorLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1, length : 2 });
  test.true( _.container.like( src ) );

  test.case = 'countable & countableLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1 });
  test.true( _.container.like( src ) );

  test.case = 'Global & GlobalReal';
  var src = global;
  test.true( _.container.like( src ) );

  test.case = 'Global & GlobalDerived';
  var src = Object.create( global );
  test.true( _.container.like( src ) );

  test.case = 'Object & ObjectLike & Container & ContainerLike';
  var src = { [ Symbol.iterator ] : 1 };
  test.true( _.container.like( src ) );

  test.case = 'Object & ObjectLike & auxiliary & auxiliaryPrototyped & auxiliaryPolluted';
  var src = { a : 1 };
  Object.setPrototypeOf( src, { b : 2 } )
  test.true( _.container.like( src ) );

  test.case = 'Object & ObjectLike & auxiliary & map & mapPure';
  var src = Object.create( null );
  test.true( _.container.like( src ) );

  test.case = 'Object & ObjectLike & auxiliary & auxiliaryPolluted & map & mapPolluted & mapPrototyped';
  var src = {};
  test.true( _.container.like( src ) );

  test.case = 'HashMap';
  var src = new HashMap();
  test.true( _.container.like( src ) );

  test.case = 'Set & SetLike';
  var src = new Set();
  test.true( _.container.like( src ) );

  test.case = 'BufferNode';
  var src = BufferNode.from( 'str' );
  test.true( !_.container.like( src ) );

  test.case = 'BufferRaw';
  var src = new BufferRaw( 'str' );
  test.true( _.container.like( src ) );

  test.case = 'BufferRawShared';
  var src = new BufferRawShared( 'str' );
  test.true( _.container.like( src ) );

  test.case = 'BufferTyped';
  var src = new I8x( 20 );
  test.true( _.container.like( src ) );

  test.case = 'BufferView';
  var src = new BufferView( new BufferRaw( 20 ) )
  test.true( _.container.like( src ) );

  test.case = 'BufferBytes & BufferTyped';
  var src = new U8x( 20 );
  test.true( _.container.like( src ) );

  test.case = 'err';
  var src = _.err( 'error' );
  test.true( _.container.like( src ) );

  test.case = 'escape';
  var src = _.escape.make( 1 );
  test.true( _.container.like( src ) );

  test.case = 'interval & BufferTyped';
  var src = new F32x( 2 );
  test.true( _.container.like( src ) );

  test.case = 'pair';
  var src = _.pair.make();
  test.true( _.container.like( src ) );

  test.case = 'path & str';
  var src = '/a/b/';
  test.true( !_.container.like( src ) );

  test.case = 'propertyTransformer & filter';
  var src = _.property.filter[ 'dstAndSrcOwn' ];
  test.true( !_.container.like( src ) );

  test.case = 'propertyTransformer & mapper';
  var src = _.property.mapper[ 'assigning' ];
  test.true( !_.container.like( src ) );

  test.case = 'routine & routineLike';
  var src = routine;
  test.true( !_.container.like( src ) );

  test.case = 'timer';
  var src = _.time._begin( Infinity );
  test.true( _.container.like( src ) );
  _.time.cancel( src );

  test.case = 'date & objectLike';
  var src = new Date();
  test.true( _.container.like( src ) );

  test.case = 'null';
  var src = null;
  test.true( !_.container.like( src ) );

  test.case = 'undefined';
  var src = undefined;
  test.true( !_.container.like( src ) );

  test.case = 'Symbol null';
  var src = _.null;
  test.true( !_.container.like( src ) );

  test.case = 'Symbol undefined';
  var src = _.undefined;
  test.true( !_.container.like( src ) );

  test.case = 'Symbol Nothing';
  var src = _.nothing;
  test.true( !_.container.like( src ) );

  test.case = 'primitive';
  var src = 5;
  test.true( !_.container.like( src ) );

  test.case = 'Symbol';
  var src = Symbol( 'a' );
  test.true( !_.container.like( src ) );

  test.case = 'ConsequenceLike & promiseLike & promise';
  var src = new Promise( ( resolve, reject ) => { return resolve( 0 ) } );
  test.true( _.container.like( src ) );

  test.case = 'stream';
  var src = require( 'stream' ).Readable();
  test.true( _.container.like( src ) );

  // test.case = 'console';
  // var src = console;
  // test.true( _.container.like( src ) );

  test.case = 'printerLike';
  var src = _global.logger;
  test.true( _.container.like( src ) );

  test.case = 'process';
  var src = process;
  test.true( _.container.like( src ) );

  /* - */

  function _iterate()
  {

    let iterator = Object.create( null );
    iterator.next = next;
    iterator.index = 0;
    iterator.instance = this;
    return iterator;

    function next()
    {
      let result = Object.create( null );
      result.done = this.index === this.instance.elements.length;
      if( result.done )
      return result;
      result.value = this.instance.elements[ this.index ];
      this.index += 1;
      return result;
    }

  }

  /* */

  function countableConstructor( o )
  {
    return countableMake( this, o );
  }

  /* */

  function countableMake( dst, o )
  {
    if( dst === null )
    dst = Object.create( null );
    _.mapExtend( dst, o );
    if( o.withIterator )
    dst[ Symbol.iterator ] = _iterate;
    return dst;
  }

  function routine () {}

}

//

function lengthOf( test )
{

  test.case = 'number';
  var src = 1;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'bool & boolLike & fuzzy';
  var src = true;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'boolLike & number & fuzzyLike';
  var src = 1;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'fuzzy';
  var src = _.maybe;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'bigint';
  var src = 10n;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'str & regexpLike';
  var src = 'str';
  test.identical( _.container.lengthOf( src ), 3 );

  test.case = 'regexp & objectLike & constructible & constructibleLike';
  var src = /hello/g;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'ArgumentsArray & arrayLike';
  var src = _.argumentsArray.make();
  test.identical( _.container.lengthOf( src ), 0 );

  test.case = 'unroll';
  var src = _.unrollMake([ 2, 3, 4 ]);
  test.identical( _.container.lengthOf( src ), 3 );

  test.case = 'array';
  var src = [ 2, 3, 4 ];
  test.identical( _.container.lengthOf( src ), 3 );

  test.case = 'long & longLike';
  var src = _.longMake([ 1, 2 ]);
  test.identical( _.container.lengthOf( src ), 2 );

  test.case = 'vector & vectorLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1, length : 2 });
  test.identical( _.container.lengthOf( src ), 2 );

  test.case = 'countable & countableLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1 });
  test.identical( _.container.lengthOf( src ), 2 );

  // test.case = 'Global & GlobalReal';
  // var src = global;
  // // test.identical( _.container.lengthOf( src ), 46 ); /* Dmytro : utility Testing uses garbage collector, direct call of nodejs uses not */
  // test.identical( _.container.lengthOf( src ), 46 + ( global.gc ? 1 : 0 ) );
  //
  // test.case = 'Global & GlobalDerived';
  // var src = Object.create( global );
  // // test.identical( _.container.lengthOf( src ), 46 ); /* Dmytro : utility Testing uses garbage collector, direct call of nodejs uses not */
  // test.identical( _.container.lengthOf( src ), 46 + ( global.gc ? 1 : 0 ) );

  test.case = 'Object & ObjectLike & Container & ContainerLike';
  var src = { [ Symbol.iterator ] : 1 };
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'Object & ObjectLike & auxiliary & auxiliaryPrototyped & auxiliaryPolluted';
  var src = { a : 1 };
  Object.setPrototypeOf( src, { b : 2 } )
  test.identical( _.container.lengthOf( src ), 2 );

  test.case = 'Object & ObjectLike & auxiliary & map & mapPure';
  var src = Object.create( null );
  test.identical( _.container.lengthOf( src ), 0 );

  test.case = 'Object & ObjectLike & auxiliary & auxiliaryPolluted & map & mapPolluted & mapPrototyped';
  var src = {};
  test.identical( _.container.lengthOf( src ), 0 );

  test.case = 'HashMap';
  var src = new HashMap();
  test.identical( _.container.lengthOf( src ), 0 );

  test.case = 'Set & SetLike';
  var src = new Set();
  test.identical( _.container.lengthOf( src ), 0 );

  test.case = 'BufferNode';
  var src = BufferNode.from( 'str' );
  test.identical( _.container.lengthOf( src ), 3 );

  test.case = 'BufferRaw';
  var src = new BufferRaw( 'str' );
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'BufferRawShared';
  var src = new BufferRawShared( 'str' );
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'BufferTyped';
  var src = new I8x( 20 );
  test.identical( _.container.lengthOf( src ), 20 );

  test.case = 'BufferView';
  var src = new BufferView( new BufferRaw( 20 ) )
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'BufferBytes & BufferTyped';
  var src = new U8x( 20 );
  test.identical( _.container.lengthOf( src ), 20 );

  test.case = 'err';
  var src = _.err( 'error' );
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'escape';
  var src = _.escape.make( 1 );
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'interval & BufferTyped';
  var src = new F32x( 2 );
  test.identical( _.container.lengthOf( src ), 2 );

  test.case = 'pair';
  var src = _.pair.make();
  test.identical( _.container.lengthOf( src ), 2 );

  test.case = 'path & str';
  var src = '/a/b/';
  test.identical( _.container.lengthOf( src ), 5 );

  test.case = 'propertyTransformer & filter';
  var src = _.property.filter[ 'dstAndSrcOwn' ];
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'propertyTransformer & mapper';
  var src = _.property.mapper[ 'assigning' ];
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'routine & routineLike';
  var src = routine;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'timer';
  var src = _.time._begin( Infinity );
  test.identical( _.container.lengthOf( src ), 9 );
  _.time.cancel( src );

  test.case = 'date & objectLike';
  var src = new Date();
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'null';
  var src = null;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'undefined';
  var src = undefined;
  test.identical( _.container.lengthOf( src ), 0 );

  test.case = 'Symbol null';
  var src = _.null;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'Symbol undefined';
  var src = _.undefined;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'Symbol Nothing';
  var src = _.nothing;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'primitive';
  var src = 5;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'Symbol';
  var src = Symbol( 'a' );
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'ConsequenceLike & promiseLike & promise';
  var src = new Promise( ( resolve, reject ) => { return resolve( 0 ) } );
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'stream';
  var src = require( 'stream' ).Readable();
  test.identical( _.container.lengthOf( src ), 1 );

  // test.case = 'console';
  // var src = console;
  // test.identical( _.container.lengthOf( src ), 24 );

  test.case = 'printerLike';
  var src = _global.logger;
  test.identical( _.container.lengthOf( src ), 9 );

  test.case = 'process';
  var src = process;
  test.identical( _.container.lengthOf( src ), 1 );

  test.case = 'instance with fields and iterator method with length 5';
  var src = new function()
  {
    this[ Symbol.iterator ] = function ()
    {
      let current = 0;
      let last = 4;
      return {
        next()
        {
          if( current <= last )
          {
            return {
              done : false,
              value : current++
            };
          }
          else
          {
            return {
              done : true
            };
          }
        }
      }
    }
  }
  test.identical( _.container.lengthOf( src ), 5 );

  /* - */

  function _iterate()
  {

    let iterator = Object.create( null );
    iterator.next = next;
    iterator.index = 0;
    iterator.instance = this;
    return iterator;

    function next()
    {
      let result = Object.create( null );
      result.done = this.index === this.instance.elements.length;
      if( result.done )
      return result;
      result.value = this.instance.elements[ this.index ];
      this.index += 1;
      return result;
    }

  }

  /* */

  function countableConstructor( o )
  {
    return countableMake( this, o );
  }

  /* */

  function countableMake( dst, o )
  {
    if( dst === null )
    dst = Object.create( null );
    _.mapExtend( dst, o );
    if( o.withIterator )
    dst[ Symbol.iterator ] = _iterate;
    return dst;
  }

  function routine () {}


}

//

function instanceOfContainer( test )
{

  test.case = 'not';
  test.identical( null instanceof _.container, false );
  test.identical( undefined instanceof _.container, false );
  test.identical( 'str' instanceof _.container, false );
  test.identical( 0 instanceof _.container, false );
  test.identical( 1 instanceof _.container, false );
  test.identical( false instanceof _.container, false );
  test.identical( true instanceof _.container, false );
  test.identical( new Date() instanceof _.container, false );

  test.case = 'map';
  test.identical( {} instanceof _.container, true );
  var map = { a : 1 };
  test.identical( map instanceof _.container, true );
  var map = Object.create( null );
  test.identical( map instanceof _.container, true );

  test.case = 'hashmap';
  test.identical( new HashMap instanceof _.container, true );
  test.identical( new HashMap([ [ 'a', 'b' ] ]) instanceof _.container, true );

  test.case = 'array';
  test.identical( [] instanceof _.container, true );
  test.identical( [ false ] instanceof _.container, true );

  test.case = 'typed buffer';
  test.identical( new F32x() instanceof _.container, true );
  test.identical( new F32x([ 1, 2, 3 ]) instanceof _.container, true );

  test.case = 'set';
  test.identical( new Set instanceof _.container, true );
  test.identical( new Set([ 'a', 'b' ]) instanceof _.container, true );

}

//

/* qqq : normalize the test, please | Dmytro : normalized, extended coverage, improved routine extendReplacing by using correct condition */

function extendReplacingDstNull( test )
{
  test.case = 'src - empty array';
  var dst = null;
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled array';
  var dst = null;
  var src = [ 0, 1 ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 0, 1 ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty array';
  var dst = undefined;
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled array';
  var dst = undefined;
  var src = [ 0, 1 ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 0, 1 ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty simple map';
  var dst = null;
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = null;
  var src = { a : 1, b : 2 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty simple map';
  var dst = undefined;
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = undefined;
  var src = { a : 1, b : 2 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty pure map';
  var dst = null;
  var src = Object.create( null );
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled pure map';
  var dst = null;
  var src = Object.create( null );
  src[ 'a' ] = 1;
  src[ 'b' ] = 2;
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty pure map';
  var dst = undefined;
  var src = Object.create( null );
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = undefined;
  var src = Object.create( null );
  src[ 'a' ] = 1;
  src[ 'b' ] = 2;
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty Set';
  var dst = null;
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled Set';
  var dst = null;
  var src = new Set( [ 0, 1 ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 0, 1 ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty Set';
  var dst = undefined;
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled Set';
  var dst = undefined;
  var src = new Set( [ 0, 1 ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 0, 1 ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty HashMap';
  var dst = null;
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled HashMap';
  var dst = null;
  var src = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty HashMap';
  var dst = undefined;
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = undefined;
  var src = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - primitive';
  var dst = null;
  var src = 'str';
  var got = _.container.extendReplacing( dst, src );
  var exp = 'str';
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got === src );

  test.case = 'src - BufferRaw';
  var dst = undefined;
  var src = new BufferRaw( 10 );
  var got = _.container.extendReplacing( dst, src );
  var exp = new BufferRaw( 10 );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got === src );

  /* - */

  test.open( 'src - not container' );

  test.case = 'dst - primitive, src - primitive';
  var dst = 'str';
  var got = _.container.extendReplacing( dst, 1 );
  var exp = 1;
  test.identical( got, exp );

  test.case = 'dst - long, src - primitive';
  var dst = [ 1, 2 ];
  var got = _.container.extendReplacing( dst, 1 );
  var exp = 1;
  test.identical( got, exp );

  test.case = 'dst - map, src - primitive';
  var dst = { a : 2 };
  var got = _.container.extendReplacing( dst, 'str' );
  var exp = 'str';
  test.identical( got, exp );

  test.case = 'dst - HashMap, src - primitive';
  var dst = new Map( [ [ undefined, undefined ] ] );
  var got = _.container.extendReplacing( dst, null );
  var exp = null;
  test.identical( got, exp );

  test.case = 'dst - Set, src - primitive';
  var dst = new Set( [ 1, 2 ] );
  var got = _.container.extendReplacing( dst, undefined );
  var exp = undefined;
  test.identical( got, exp );

  /* */

  test.case = 'dst - long, src - BufferRaw';
  var dst = [ 1, 2 ];
  var src = new BufferRaw();
  var got = _.container.extendReplacing( dst, src );
  var exp = new BufferRaw();
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - map, src - function';
  var dst = { a : 2 };
  var src = () => {};
  var got = _.container.extendReplacing( dst, src );
  var exp = src;
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - HashMap, src - BufferView';
  var dst = new Map( [ [ undefined, undefined ] ] );
  var src = new BufferView( new BufferRaw() );
  var got = _.container.extendReplacing( dst, src );
  var exp = new BufferView( new BufferRaw() );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - Set, src - object';
  var dst = new Set( [ 1, 2 ] );
  function Constr()
  {
    this.x = 1;
    return this;
  };
  var src = new Constr();
  var got = _.container.extendReplacing( dst, src );
  test.identical( got.x, 1 );
  test.true( got === src );

  test.close( 'src - not container' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.container.extendReplacing() );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.container.extendReplacing( [ 1, 3 ], [ 1, 3 ], [ 1, 3 ] ) );

  test.case = 'src is WeakMap';
  test.shouldThrowErrorSync( () => _.container.extendReplacing( { a : 1 }, new WeakMap() ) );

  test.case = 'src is WeakSet';
  test.shouldThrowErrorSync( () => _.container.extendReplacing( new Set( [ 1, 2 ] ), new WeakSet( [ 1, 2 ] ) ) );
}

//

function extendReplacingDstMapAndHashMapLike( test )
{
  test.open( 'src - aixiliary' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty map';
  var dst = {};
  var src = { a : 3, b : 5, c : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { a : 3, b : 5, c : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, different content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = { d : 3, e : 5, f : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { a : 1, b : 2, c : 3, d : 3, e : 5, f : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, almost identical content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { a : 1, b : 2, c : 3 };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = { a : 3, b : 5, c : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, different content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = { d : 3, e : 5, f : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ], [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, almost identical content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = { a : 1, b : 2, c : 3 };
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty long';
  var dst = [];
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 3, 'b' : 5, 'c' : 6 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - long, src - empty';
  var dst = [ 9, -16 ];
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - long';
  var dst = [ 9, -16 ];
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 3, 'b' : 5, 'c' : 6 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 3, 'b' : 5, 'c' : 6 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set, src - empty';
  var dst = new Set( [ 9, -16 ] );
  var src = {};
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set';
  var dst = new Set( [ 9, -16 ] );
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendReplacing( dst, src );
  var exp = { 'a' : 3, 'b' : 5, 'c' : 6 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.close( 'src - aixiliary' );

  /* - */

  test.open( 'src - hashMapLike' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty map';
  var dst = {};
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = { a : 3, b : 5, c : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, different content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Map( [ [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = { a : 1, b : 2, c : 3, d : 3, e : 5, f : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, almost identical content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = { a : 1, b : 2, c : 3 };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, different content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Map( [ [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ], [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, almost identical content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty long';
  var dst = [];
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - long, src - empty';
  var dst = [ 9, -16 ];
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - long';
  var dst = [ 9, -16 ];
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set, src - empty';
  var dst = new Set( [ 9, -16 ] );
  var src = new Map();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set';
  var dst = new Set( [ 9, -16 ] );
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.close( 'src - hashMapLike' );
}

//

function extendReplacingDstLongAndSetLike( test )
{
  test.open( 'src - longLike' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty map';
  var dst = {};
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map, src - empty';
  var dst = { 'a' : 1, 'b' : 2, 'c' : 3 };
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map';
  var dst = { 'a' : 1, 'b' : 2, 'c' : 3 };
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap, src - empty';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty long';
  var dst = [];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long, different content';
  var dst = [ 1, 2, 3 ];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, almost identical content';
  var dst = [ 9, -16, 'str', null ];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - long, src - long';
  var dst = [ 1, 2, 3 ];
  var src = [ 4, 5, 6, 7 ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 4, 5, 6, 7 ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long not extensible, src - long';
  var dst = [ 1, 2, 3 ];
  var src = [ 4, 5, 6 ];
  Object.preventExtensions( dst );
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 4, 5, 6 ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long not extensible, src - long';
  var dst = [ 1, 2, 3 ];
  var src = [ 4, 5, 6, 7 ];
  Object.preventExtensions( dst );
  test.shouldThrowErrorSync( () => _.container.extendReplacing( dst, src ) );
  test.identical( dst, [ 1, 2, 3 ] );
  test.identical( src, [ 4, 5, 6, 7 ] );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set, src - empty';
  var dst = new Set( [ 9, -16 ] );
  var src = [];
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set';
  var dst = new Set( [ 9, -16 ] );
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.close( 'src - longLike' );

  /* - */

  test.open( 'src - setLike' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty map';
  var dst = {};
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map, src -empty';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap, src - empty';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap, almost identical content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty long';
  var dst = [];
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long, different content';
  var dst = [ 1, 2 ];
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 1, 2, 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long, almost identical content';
  var dst = [ 9, -16, 'str', null ];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendReplacing( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = new Set();
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - Set, different content';
  var dst = new Set( [ 1, 2 ] );
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 1, 2, 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - Set, almost identical content';
  var dst = new Set( [ 9, -16, 'str', null ] );
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendReplacing( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.close( 'src - setLike' );
}

//

/* aaa : normalize the test, please | Dmytro : normalized, extended coverage */

function extendAppendingDstNull( test )
{
  test.case = 'src - empty array';
  var dst = null;
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled array';
  var dst = null;
  var src = [ 0, 1 ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 0, 1 ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty array';
  var dst = undefined;
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled array';
  var dst = undefined;
  var src = [ 0, 1 ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 0, 1 ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty simple map';
  var dst = null;
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = null;
  var src = { a : 1, b : 2 };
  var got = _.container.extendAppending( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty simple map';
  var dst = undefined;
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = undefined;
  var src = { a : 1, b : 2 };
  var got = _.container.extendAppending( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty pure map';
  var dst = null;
  var src = Object.create( null );
  var got = _.container.extendAppending( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled pure map';
  var dst = null;
  var src = Object.create( null );
  src[ 'a' ] = 1;
  src[ 'b' ] = 2;
  var got = _.container.extendAppending( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty pure map';
  var dst = undefined;
  var src = Object.create( null );
  var got = _.container.extendAppending( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = undefined;
  var src = Object.create( null );
  src[ 'a' ] = 1;
  src[ 'b' ] = 2;
  var got = _.container.extendAppending( dst, src );
  var exp = { 'a' : 1, 'b' : 2 };
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty Set';
  var dst = null;
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled Set';
  var dst = null;
  var src = new Set( [ 0, 1 ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 0, 1 ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty Set';
  var dst = undefined;
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled Set';
  var dst = undefined;
  var src = new Set( [ 0, 1 ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 0, 1 ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - empty HashMap';
  var dst = null;
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled HashMap';
  var dst = null;
  var src = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - empty HashMap';
  var dst = undefined;
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'src - filled simple map';
  var dst = undefined;
  var src = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 2, 2 ] ] );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'src - primitive';
  var dst = null;
  var src = 'str';
  var got = _.container.extendAppending( dst, src );
  var exp = 'str';
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got === src );

  test.case = 'src - BufferRaw';
  var dst = undefined;
  var src = new BufferRaw( 10 );
  var got = _.container.extendAppending( dst, src );
  var exp = new BufferRaw( 10 );
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got === src );

  /* - */

  test.open( 'src - not container' );

  test.case = 'dst - long, src - primitive';
  var dst = [ 1, 2 ];
  var got = _.container.extendAppending( dst, 1 );
  var exp = [ 1, 2, 1 ];
  test.identical( got, exp );

  test.case = 'dst - map, src - primitive';
  var dst = { a : 2 };
  var got = _.container.extendAppending( dst, 'str' );
  var exp = [ { a : 2 }, 'str' ];
  test.identical( got, exp );

  test.case = 'dst - HashMap, src - primitive';
  var dst = new Map( [ [ undefined, undefined ] ] );
  var got = _.container.extendAppending( dst, null );
  var exp = [ new Map( [ [ undefined, undefined ] ] ), null ];
  test.identical( got, exp );

  test.case = 'dst - Set, src - primitive';
  var dst = new Set( [ 1, 2 ] );
  var got = _.container.extendAppending( dst, undefined );
  var exp = [ new Set( [ 1, 2 ] ), undefined ];
  test.identical( got, exp );

  /* */

  test.case = 'dst - long, src - BufferRaw';
  var dst = [ 1, 2 ];
  var got = _.container.extendAppending( dst, new BufferRaw() );
  var exp = [ 1, 2, new BufferRaw() ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, src - function';
  var dst = { a : 2 };
  var func = () => {};
  var got = _.container.extendAppending( dst, func );
  var exp = [ { a : 2 }, func ];
  test.identical( got, exp );

  test.case = 'dst - HashMap, src - BufferView';
  var dst = new Map( [ [ undefined, undefined ] ] );
  var got = _.container.extendAppending( dst, new BufferView( new BufferRaw() ) );
  var exp = [ new Map( [ [ undefined, undefined ] ] ), new BufferView( new BufferRaw() ) ];
  test.identical( got, exp );

  test.case = 'dst - Set, src - object';
  var dst = new Set( [ 1, 2 ] );
  function Constr()
  {
    this.x = 1;
    return this;
  };
  var constr = new Constr();
  var got = _.container.extendAppending( dst, constr );
  var exp = [ dst, constr ];
  test.identical( got, exp );

  test.close( 'src - not container' );

  /* - */

  test.open( 'dst - not container' );

  test.case = 'dst - primitive, src - primitive';
  var dst = 'str';
  var got = _.container.extendAppending( dst, 1 );
  var exp = 1;
  test.identical( got, exp );

  test.case = 'dst - primitive, src - long';
  var dst = 1;
  var src = [ 1, 2 ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 1, 2 ];
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - primitive, src - map';
  var dst = 'str';
  var src = { a : 2 };
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 2 };
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - primitive, src - HashMap';
  var dst = true;
  var src = new Map( [ [ undefined, undefined ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ undefined, undefined ] ] );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - primitive, src - set';
  var dst = false;
  var src = new Set( [ 1, 2 ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 1, 2 ] );
  test.identical( got, exp );
  test.true( got === src );

  /* */

  test.case = 'dst - BufferRaw, src - long';
  var dst = new BufferRaw();
  var src = [ 1, 2 ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 1, 2 ];
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - function, src - map';
  var dst = () => {};
  var src = { a : 2 };
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 2 };
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - BufferView, src - HashMap';
  var dst = new BufferView( new BufferRaw() );
  var src = new Map( [ [ undefined, undefined ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ undefined, undefined ] ] );
  test.identical( got, exp );
  test.true( got === src );

  test.case = 'dst - object, src - Set';
  function Constr()
  {
    this.x = 1;
    return this;
  };
  var dst = new Constr;
  var src = new Set( [ 1, 2 ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 1, 2 ] );
  test.identical( got, exp );
  test.true( got === src );

  test.close( 'dst - not container' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.container.extendAppending() );

  test.case = 'extra argument';
  test.shouldThrowErrorSync( () => _.container.extendAppending( [ 1, 3 ], [ 1, 3 ], [ 1, 3 ] ) );

  test.case = 'src is WeakMap';
  test.shouldThrowErrorSync( () => _.container.extendAppending( { a : 1 }, new WeakMap() ) );

  test.case = 'src is WeakSet';
  test.shouldThrowErrorSync( () => _.container.extendAppending( new Set( [ 1, 2 ] ), new WeakSet( [ 1, 2 ] ) ) );
}

//

function extendAppendingDstMapAndHashMapLike( test )
{
  test.open( 'src - aixiliary' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty map';
  var dst = {};
  var src = { a : 3, b : 5, c : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 3, b : 5, c : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, different content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = { d : 3, e : 5, f : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 1, b : 2, c : 3, d : 3, e : 5, f : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, almost identical content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = { a : 1, b : 2, c : 3 };
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 1, b : 2, c : 3 };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = { a : 3, b : 5, c : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, different content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = { d : 3, e : 5, f : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ], [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, almost identical content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = { a : 1, b : 2, c : 3 };
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = [ {} ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - empty long';
  var dst = [];
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = [ { 'a' : 3, 'b' : 5, 'c' : 6 } ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - long, src - empty';
  var dst = [ 9, -16 ];
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, {} ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - long';
  var dst = [ 9, -16 ];
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, { 'a' : 3, 'b' : 5, 'c' : 6 } ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set(), {} ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set(), { 'a' : 3, 'b' : 5, 'c' : 6 } ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set, src - empty';
  var dst = new Set( [ 9, -16 ] );
  var src = {};
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set( [ 9, -16 ] ), {} ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set';
  var dst = new Set( [ 9, -16 ] );
  var src = { 'a' : 3, 'b' : 5, 'c' : 6 };
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set( [ 9, -16 ] ), { 'a' : 3, 'b' : 5, 'c' : 6 } ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.close( 'src - aixiliary' );

  /* - */

  test.open( 'src - hashMapLike' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty map';
  var dst = {};
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 3, b : 5, c : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, different content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Map( [ [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 1, b : 2, c : 3, d : 3, e : 5, f : 6 };
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, almost identical content';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = { a : 1, b : 2, c : 3 };
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = new Map();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, different content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Map( [ [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ], [ 'd', 3 ], [ 'e', 5 ], [ 'f', 6 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - HashMap, almost identical content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map() ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - empty long';
  var dst = [];
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] ) ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - long, src - empty';
  var dst = [ 9, -16 ];
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, new Map() ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - long';
  var dst = [ 9, -16 ];
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] ) ];
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set(), new Map() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set(), new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set, src - empty';
  var dst = new Set( [ 9, -16 ] );
  var src = new Map();
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set( [ 9, -16 ] ), new Map() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - Set';
  var dst = new Set( [ 9, -16 ] );
  var src = new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set( [ 9, -16 ] ), new Map( [ [ 'a', 3 ], [ 'b', 5 ], [ 'c', 6 ] ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.close( 'src - hashMapLike' );
}

//

function extendAppendingDstLongAndSetLike( test )
{
  test.open( 'src - longLike' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = [ {} ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty map';
  var dst = {};
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ {}, 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map, src - empty';
  var dst = { 'a' : 1, 'b' : 2, 'c' : 3 };
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ { 'a' : 1, 'b' : 2, 'c' : 3 }, 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map';
  var dst = { 'a' : 1, 'b' : 2, 'c' : 3 };
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ { 'a' : 1, 'b' : 2, 'c' : 3 }, 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map(), 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap, src - empty';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] ), 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = [];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty long';
  var dst = [];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long, different content';
  var dst = [ 1, 2, 3 ];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 1, 2, 3, 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - map, almost identical content';
  var dst = [ 9, -16, 'str', null ];
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, 'str', null, 9, -16, 'str', null ];
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - Set, src - empty';
  var dst = new Set( [ 9, -16 ] );
  var src = [];
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 9, -16 ] );
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.case = 'dst - Set';
  var dst = new Set( [ 9, -16 ] );
  var src = [ 9, -16, 'str', null ];
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );
  test.true( got !== src );

  test.close( 'src - longLike' );

  /* - */

  test.open( 'src - setLike' );

  test.case = 'dst - empty map, src - empty';
  var dst = {};
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = [ {}, new Set() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty map';
  var dst = {};
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ {}, new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map, src -empty';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = [ { a : 1, b : 2, c : 3 }, new Set() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - map';
  var dst = { a : 1, b : 2, c : 3 };
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ { a : 1, b : 2, c : 3 }, new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty HashMap, src - empty';
  var dst = new Map();
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map(), new Set() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - empty HashMap';
  var dst = new Map();
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map(), new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap, src - empty';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] ), new Set() ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  test.case = 'dst - HashMap, almost identical content';
  var dst = new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] );
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Map( [ [ 'a', 1 ], [ 'b', 2 ], [ 'c', 3 ] ] ), new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got !== dst );
  test.true( got !== src );

  /* */

  test.case = 'dst - empty long, src - empty';
  var dst = [];
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set() ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty long';
  var dst = [];
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long, different content';
  var dst = [ 1, 2 ];
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ 1, 2, new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - long, almost identical content';
  var dst = [ 9, -16, 'str', null ];
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = [ 9, -16, 'str', null, new Set( [ 9, -16, 'str', null ] ) ];
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'dst - empty Set, src - empty';
  var dst = new Set();
  var src = new Set();
  var got = _.container.extendAppending( dst, src );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - empty Set';
  var dst = new Set();
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - Set, different content';
  var dst = new Set( [ 1, 2 ] );
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 1, 2, 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'dst - Set, almost identical content';
  var dst = new Set( [ 9, -16, 'str', null ] );
  var src = new Set( [ 9, -16, 'str', null ] );
  var got = _.container.extendAppending( dst, src );
  var exp = new Set( [ 9, -16, 'str', null ] );
  test.identical( got, exp );
  test.true( got === dst );

  test.close( 'src - setLike' );
}

//

function empty( test )
{
  test.case = 'empty array';
  var dst = [];
  var got = _.container.empty( dst );
  var exp = [];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'filled array';
  var dst = [ 1, null, undefined, 'str', '', false, {}, [], [ 1 ], { a : 1 } ];
  var got = _.container.empty( dst );
  var exp = [];
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'empty unroll';
  var dst = _.unrollMake( [] );
  var got = _.container.empty( dst );
  var exp = _.unrollMake( [] );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'filled unroll';
  var dst = _.unrollMake( [ 1, null, undefined, 'str', '', false, {}, [], [ 1 ], { a : 1 } ] );
  var got = _.container.empty( dst );
  var exp = _.unrollMake( [] );
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'empty Set';
  var dst = new Set();
  var got = _.container.empty( dst );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'filled Set';
  var dst = new Set( [ 1, null, undefined, 'str', '', false, {}, [], [ 1 ], { a : 1 } ] );
  var got = _.container.empty( dst );
  var exp = new Set();
  test.identical( got, exp );
  test.true( got === dst );

  /* */

  test.case = 'empty Map';
  var dst = new Map();
  var got = _.container.empty( dst );
  var exp = new Map();
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.true( got === dst );

  test.case = 'filled Map';
  var dst = new Map( [ [ 1, 1 ], [ null, null ], [ undefined, undefined ], [ 'str', 'str' ], [ '', '' ], [ false, false ], [ {}, {} ], [ [], [] ] ] );
  var got = _.container.empty( dst );
  var exp = new Map();
  test.identical( [ ... got.entries() ], [ ... exp.entries() ] );
  test.true( got === dst );

  /* */

  test.case = 'empty simple map';
  var dst = {};
  var got = _.container.empty( dst );
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'filled simple map';
  var dst = { '1' : 1, 'null' : null, 'str' : 'str', '' : '', 'false' : false };
  var got = _.container.empty( dst );
  var exp = {};
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'empty pure map';
  var dst = Object.create( null );
  var got = _.container.empty( dst );
  var exp = Object.create( null );
  test.identical( got, exp );
  test.true( got === dst );

  test.case = 'filled simple map';
  var dst = Object.create( null );
  dst[ '1' ] = 1;
  dst[ 'null' ] = null;
  dst[ 'undefined' ] = undefined;
  var got = _.container.empty( dst );
  var exp = Object.create( null );
  test.identical( got, exp );
  test.true( got === dst );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'wrong type of dst';
  test.shouldThrowErrorSync( () => _.container.empty() );
  test.shouldThrowErrorSync( () => _.container.empty( 'wrong' ) );
  test.shouldThrowErrorSync( () => _.container.empty( 1 ) );
  function Constr()
  {
    this.x = 1;
    return this
  };
  test.shouldThrowErrorSync( () => _.container.empty( new Constr() ) );

  test.case = 'not resizable longs';
  test.shouldThrowErrorSync( () => _.container.empty( _.argumentsArray.make( [] ) ) );
  test.shouldThrowErrorSync( () => _.container.empty( new U8x() ) );
  test.shouldThrowErrorSync( () => _.container.empty( new F64x() ) );

  test.case = 'dst is WeakMap';
  test.shouldThrowErrorSync( () => _.container.empty( new WeakMap() ) );
}

//

function elementThGet( test ) /* xxx : types that cause error marked with - 'else _.assert( 0 );' and commented */
{

  /* */

  test.case = 'map';
  var src = { a : 1, b : 2 };
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 'a', 1 ] );
  var got = _.container.elementThGet( src, 1 );
  test.identical( got, [ 'b', 2 ] );

  /* */

  test.case = 'hashmap';
  var src = new HashMap();
  src.set( 'a', 1 );
  src.set( 'b', 2 );
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 'a', 1 ] );
  var got = _.container.elementThGet( src, 1 );
  test.identical( got, [ 'b', 2 ] );

  /* */

  test.case = 'array';
  var src = [ 1, 2 ];
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 1 ] );
  var got = _.container.elementThGet( src, 1 );
  test.identical( got, [ 1, 2 ] );

  /* */

  test.case = 'set';
  var src = new Set([ 1, 2 ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 1 ] );
  var got = _.container.elementThGet( src, 1 );
  test.identical( got, [ 1, 2 ] );

  /* */

  test.case = 'escape';
  var src = new _.Escape( 'abc' );
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 'abc' ] );
  var got = _.container.elementThGet( src, 1 );
  test.identical( got, [ 1, undefined ] );

  /* */

  test.case = 'string';
  var src = 'abc';
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 'a' ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, 'b' ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, 'c' ] );
  var got4 = _.container.elementThGet( src, 3 );
  test.identical( got4, [ 3, undefined ] );

  test.case = 'ArgumentsArray & arrayLike';
  var src = _.argumentsArray.make([ 1, 2, 3 ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 1 ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, 2 ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, 3 ] );
  var got4 = _.container.elementThGet( src, 3 );
  test.identical( got4, [ 3, undefined ] );

  test.case = 'unroll';
  var src = _.unrollMake([ 1, 2, 3 ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 1 ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, 2 ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, 3 ] );
  var got4 = _.container.elementThGet( src, 3 );
  test.identical( got4, [ 3, undefined ] );

  test.case = 'long & longLike';
  var src = _.longMake([ 1, 2, 3 ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 1 ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, 2 ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, 3 ] );
  var got4 = _.container.elementThGet( src, 3 );
  test.identical( got4, [ 3, undefined ] );

  test.case = 'vector & vectorLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1, length : 2 });
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, '1' ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, '10' ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, undefined ] );

  test.case = 'countable & countableLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1 });
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, '1' ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, '10' ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, undefined ] );

  /* else _.assert( 0 ); */
  // test.case = 'Global & GlobalReal';
  // var src = global;
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, 1 );

  /* else _.assert( 0 ); */
  // test.case = 'Global & GlobalDerived';
  // var src = Object.create( global );
  // var got = _.container.elementThGet( src, 1 );
  // test.identical( _.object.is( got ), true );

  /* else _.assert( 0 ); */
  // test.case = 'Object & ObjectLike & Container & ContainerLike';
  // var src = { [ Symbol.iterator ] : 1, a : 1 };
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, [ 0, 1 ] );

  test.case = 'Object & ObjectLike & auxiliary & auxiliaryPrototyped & auxiliaryPolluted';
  var src = { a : 1 };
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 'a', 1 ] );

  test.case = 'Object & ObjectLike & auxiliary & map & mapPure';
  var src = Object.create( null );
  src.a = 1;
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 'a', 1 ] );

  test.case = 'HashMap';
  var objRef = { a : 1 };
  var src = new HashMap([ [ 'a', 1 ], [ true, false ], [ objRef, { a : 2 } ] ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 'a', 1 ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ true, false ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ objRef, { a : 2 } ] );

  test.case = 'Set & SetLike';
  var objRef = { a : 1 };
  var src = new Set([ 'a', 1, true, objRef ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 'a' ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, 1 ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, true ] );
  var got4 = _.container.elementThGet( src, 3 );
  test.identical( got4, [ 3, objRef ] );

  test.case = 'BufferNode';
  var src = BufferNode.from( 'str' );
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 115 ] );

  /* else _.assert( 0 ); */
  // test.case = 'BufferRaw';
  // var src = new BufferRaw( 10 );
  // var got = _.container.elementThGet( src, 1 );
  // test.identical( got, 10 );

  /* else _.assert( 0 ); */
  // test.case = 'BufferRawShared';
  // var src = new BufferRawShared( 15 );
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, 15 );

  test.case = 'BufferTyped';
  var src = new I8x( 20 );
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 0 ] );

  /* else _.assert( 0 ); */
  // test.case = 'BufferView';
  // var src = new BufferView( new BufferRaw( 20 ) )
  // var got = _.container.elementThGet( src, 1 );
  // test.identical( got, 20 );

  /* else _.assert( 0 ); */
  // test.case = 'err';
  // var src = _.err( 'error' );
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( _.strIs( got ), true );

  test.case = 'pair';
  var src = _.pair.make([ 1, 2 ]);
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 0, 1 ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 1, 2 ] );
  var got3 = _.container.elementThGet( src, 2 );
  test.identical( got3, [ 2, undefined ] );

  /* else _.assert( 0 ); */
  // test.case = 'propertyTransformer & filter';
  // var src = _.property.filter[ 'dstAndSrcOwn' ];
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, { 'propertyFilter' : true, 'propertyTransformer' : true, 'functor' : true } );

  /* else _.assert( 0 ); */
  // test.case = 'propertyTransformer & mapper';
  // var src = _.property.mapper[ 'assigning' ];
  // var got = _.container.elementThGet( src, 1 );
  // test.identical( got, { 'propertyMapper' : true, 'propertyTransformer' : true, 'functor' : true } );

  /* else _.assert( 0 ); */
  // test.case = 'routine & routineLike';
  // var src = routine;
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, 'routine' );

  test.case = 'timer';
  var src = _.time._begin( Infinity );
  var got = _.container.elementThGet( src, 0 );
  test.identical( got, [ 'onTime', undefined ] );
  var got2 = _.container.elementThGet( src, 1 );
  test.identical( got2, [ 'onCancel', undefined ] );
  _.time.cancel( src );

  /* else _.assert( 0 ); */
  // test.case = 'date & objectLike';
  // var src = new Date( 1000 );
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, true );

  /* else _.assert( 0 ); */
  // test.case = 'stream';
  // var src = require( 'stream' ).Readable();
  // var got = _.container.elementThGet( src, 1 );
  // test.identical( got, true );

  /* else _.assert( 0 ); */
  // test.case = 'process';
  // var src = process;
  // var got = _.container.elementThGet( src, 0 );
  // test.identical( got, undefined );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args'
  test.shouldThrowErrorSync( () => _.container.elementThGet() );

  test.case = 'to many args'
  test.shouldThrowErrorSync( () => _.container.elementThGet( [ 1, 2, 3 ], 1, 2 ) );

  test.case = 'container = primitive'
  test.shouldThrowErrorSync( () => _.container.elementThGet( 1, 0 ) );

  /* - */

  function _iterate()
  {

    let iterator = Object.create( null );
    iterator.next = next;
    iterator.index = 0;
    iterator.instance = this;
    return iterator;

    function next()
    {
      let result = Object.create( null );
      result.done = this.index === this.instance.elements.length;
      if( result.done )
      return result;
      result.value = this.instance.elements[ this.index ];
      this.index += 1;
      return result;
    }

  }

  /* */

  function countableConstructor( o )
  {
    return countableMake( this, o );
  }

  /* */

  function countableMake( dst, o )
  {
    if( dst === null )
    dst = Object.create( null );
    _.mapExtend( dst, o );
    if( o.withIterator )
    dst[ Symbol.iterator ] = _iterate;
    return dst;
  }

  /* */

  function routine () {}

  /* */

  function Obj1( o )
  {
    _.mapExtend( this, o );
    return this;
  }

}

//

function elementGet( test )
{

  /* */

  test.case = 'prototype';
  var src = new Obj1({});
  var got = _.container.elementGet( src, _.escape.prototype );
  test.true( got === Obj1.prototype );

  /* */

  test.case = 'string';
  var src = 'abc';
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 'a' );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 'b' );
  var got3 = _.container.elementGet( src, '2' );
  test.identical( got3, 'c' );

  test.case = 'number';
  var src = 100;
  var got = _.container.elementGet( src, '0' );
  test.identical( got, undefined );

  test.case = 'ArgumentsArray & arrayLike';
  var src = _.argumentsArray.make([ 1, 2, 3 ]);
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 1 );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 2 );
  var got3 = _.container.elementGet( src, '2' );
  test.identical( got3, 3 );

  test.case = 'unroll';
  var src = _.unrollMake([ 1, 2, 3 ]);
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 1 );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 2 );
  var got3 = _.container.elementGet( src, '2' );
  test.identical( got3, 3 );

  test.case = 'array';
  var src = [ 1, 2, 3 ];
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 1 );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 2 );
  var got3 = _.container.elementGet( src, '2' );
  test.identical( got3, 3 );

  test.case = 'long & longLike';
  var src = _.longMake([ 1, 2, 3 ]);
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 1 );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 2 );
  var got3 = _.container.elementGet( src, '2' );
  test.identical( got3, 3 );

  test.case = 'vector & vectorLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1, length : 2 });
  var got = _.container.elementGet( src, 'elements' );
  test.identical( got, [ '1', '10' ] );

  test.case = 'vector & vectorLike wit 3 elems';
  var src = new countableConstructor({ element1 : '1', element2 : 1, withIterator : 1, length : 2 });
  var got = _.container.elementGet( src, 'element1' );
  test.identical( got, '1' );
  var got2 = _.container.elementGet( src, 'element2' );
  test.identical( got2, 1 );

  test.case = 'countable & countableLike';
  var src = new countableConstructor({ elements : [ '1', '10' ], withIterator : 1 });
  var got = _.container.elementGet( src, 'elements' );
  test.identical( got, [ '1', '10' ] );

  test.case = 'Global & GlobalReal';
  var src = global;
  var got = _.container.elementGet( src, 'wTools' );
  test.identical( _.object.is( got ), true );

  test.case = 'Global & GlobalDerived';
  var src = Object.create( global );
  var got = _.container.elementGet( src, 'wTools' );
  test.identical( _.object.is( got ), true );

  test.case = 'Object & ObjectLike & Container & ContainerLike';
  var src = { [ Symbol.iterator ] : 1, a : 1 };
  var got = _.container.elementGet( src, 'a' );
  test.identical( got, 1 );

  test.case = 'Object & ObjectLike & auxiliary & auxiliaryPrototyped & auxiliaryPolluted';
  var src = { a : 1 };
  var got = _.container.elementGet( src, 'a' );
  test.identical( got, 1 );

  test.case = 'Object & ObjectLike & auxiliary & map & mapPure';
  var src = Object.create( null );
  src.a = 1;
  var got = _.container.elementGet( src, 'a' );
  test.identical( got, 1 );

  test.case = 'HashMap';
  var objRef = { a : 1 };
  var src = new HashMap([ [ 'a', 1 ], [ true, false ], [ objRef, { a : 2 } ] ]);
  var got = _.container.elementGet( src, 'a' );
  test.identical( got, 1 );
  var got2 = _.container.elementGet( src, true );
  test.identical( got2, false );
  var got3 = _.container.elementGet( src, objRef );
  test.identical( got3, { a : 2 } );

  test.case = 'Set & SetLike';
  var objRef = { a : 1 };
  var src = new Set([ 'a', 1, true, objRef ]);
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 'a' );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 1 );
  var got3 = _.container.elementGet( src, '2' );
  test.identical( got3, true );
  var got4 = _.container.elementGet( src, '3' );
  test.identical( got4, { a : 1 } );

  test.case = 'BufferNode';
  var src = BufferNode.from( 'str' );
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 115 );

  test.case = 'BufferRaw';
  var src = new BufferRaw( 10 );
  var got = _.container.elementGet( src, 'byteLength' );
  test.identical( got, 10 );

  test.case = 'BufferRawShared';
  var src = new BufferRawShared( 15 );
  var got = _.container.elementGet( src, 'byteLength' );
  test.identical( got, 15 );

  test.case = 'BufferTyped';
  var src = new I8x( 20 );
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 0 );

  test.case = 'BufferView';
  var src = new BufferView( new BufferRaw( 20 ) )
  var got = _.container.elementGet( src, 'byteLength' );
  test.identical( got, 20 );

  test.case = 'err';
  var src = _.err( 'error' );
  var got = _.container.elementGet( src, 'message' );
  test.identical( _.strIs( got ), true );

  test.case = 'escape';
  var src = _.escape.make( 1 );
  var got = _.container.elementGet( src, 'val' );
  test.identical( got, 1 );

  test.case = 'pair';
  var src = _.pair.make([ 1, 2 ]);
  var got = _.container.elementGet( src, '0' );
  test.identical( got, 1 );
  var got2 = _.container.elementGet( src, '1' );
  test.identical( got2, 2 );

  test.case = 'propertyTransformer & filter';
  var src = _.property.filter[ 'dstAndSrcOwn' ];
  var got = _.container.elementGet( src, 'identity' );
  test.identical( got, { 'propertyFilter' : true, 'propertyTransformer' : true, 'functor' : true } );

  test.case = 'propertyTransformer & mapper';
  var src = _.property.mapper[ 'assigning' ];
  var got = _.container.elementGet( src, 'identity' );
  test.identical( got, { 'propertyMapper' : true, 'propertyTransformer' : true, 'functor' : true } );

  test.case = 'routine & routineLike';
  var src = routine;
  var got = _.container.elementGet( src, 'name' );
  test.identical( got, 'routine' );

  test.case = 'timer';
  var src = _.time._begin( Infinity );
  var got = _.container.elementGet( src, 'type' );
  test.identical( got, 'delay' );
  _.time.cancel( src );

  test.case = 'date & objectLike';
  var src = new Date( 1000 );
  var got = _.container.elementGet( src, 'getTime' );
  test.identical( _.routineIs( got ), true );

  test.case = 'stream';
  var src = require( 'stream' ).Readable();
  var got = _.container.elementGet( src, 'readable' );
  test.identical( got, true );

  test.case = 'process';
  var src = process;
  var got = _.container.elementGet( src, 'cwd' );
  test.identical( _.routine.is( got ), true );

  /* */

  if( !Config.debug )
  return;

  test.case = 'no args'
  test.shouldThrowErrorSync( () => _.container.elementGet() );

  test.case = 'to many args'
  test.shouldThrowErrorSync( () => _.container.elementGet( {}, 'a', 'b' ) );

  /* - */

  function _iterate()
  {

    let iterator = Object.create( null );
    iterator.next = next;
    iterator.index = 0;
    iterator.instance = this;
    return iterator;

    function next()
    {
      let result = Object.create( null );
      result.done = this.index === this.instance.elements.length;
      if( result.done )
      return result;
      result.value = this.instance.elements[ this.index ];
      this.index += 1;
      return result;
    }

  }

  /* */

  function countableConstructor( o )
  {
    return countableMake( this, o );
  }

  /* */

  function countableMake( dst, o )
  {
    if( dst === null )
    dst = Object.create( null );
    _.mapExtend( dst, o );
    if( o.withIterator )
    dst[ Symbol.iterator ] = _iterate;
    return dst;
  }

  /* */

  function routine () {}

  /* */

  function Obj1( o )
  {
    _.mapExtend( this, o );
    return this;
  }

}

// --
// define test suite
// --

let Self =
{

  name : 'Tools.Container',
  silencing : 1,

  tests :
  {

    is,
    like,
    lengthOf,
    instanceOfContainer,

    extendReplacingDstNull,
    extendReplacingDstMapAndHashMapLike,
    extendReplacingDstLongAndSetLike,

    extendAppendingDstNull, /* qqq : extendAppending test routine | Dmytro : split and extended coverage of routine */
    extendAppendingDstMapAndHashMapLike,
    extendAppendingDstLongAndSetLike,

    empty, /* qqq : implement test routine `empty` | Dmytro : implemented */

    elementThGet, /* qqq for Yevhen : cover | aaa : Done. */
    elementGet, /* qqq for Yevhen : cover | aaa : Done. */

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
