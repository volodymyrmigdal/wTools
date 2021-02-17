( function _l3_Prototype_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools.prototype = _global_.wTools.prototype || Object.create( null );

// --
// implementation
// --

/**
 * @namespace Tools.prototype
 * @module Tools/base/Proto
 */

function _of( object )
{
  return Object.getPrototypeOf( object );
}

//

/**
 * Iterate through prototypes.
 * @param {object} proto - prototype
 * @function each
 * @namespace Tools.prototype
 */

function each( proto, onEach )
{
  let result = [];

  _.assert( _.routineIs( onEach ) || !onEach );
  _.assert( !_.primitiveIs( proto ) || proto === null );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  while( proto )
  {
    if( onEach )
    onEach.call( this, proto );
    result.push( proto );
    proto = Object.getPrototypeOf( proto );
  }

  return result;
}

//

function isPrototypeOf( superPrototype, subPrototype ) /* xxx : move */
{
  _.assert( arguments.length === 2, 'Expects two arguments, probably you meant routine prototypeOf' );
  if( superPrototype === subPrototype )
  return true;
  if( !superPrototype )
  return false;
  if( !subPrototype )
  return false;
  return Object.isPrototypeOf.call( superPrototype, subPrototype );
}

//

/**
 * Return proto owning names.
 * @param {object} srcPrototype - src object to investigate proto stack.
 * @function havingProperty
 * @namespace Tools.prototype
 */

function havingProperty( srcPrototype, name ) /* yyy qqq : names could be only string */
{

  _.assert( !_.primitiveIs( srcPrototype ) );
  _.assert( _.strIs( name ) );

  do
  {
    let has = true;
    if( !Object.hasOwnProperty.call( srcPrototype, name ) )
    has = false;
    if( has )
    return srcPrototype;

    srcPrototype = Object.getPrototypeOf( srcPrototype );
  }
  while( srcPrototype !== Object.prototype && srcPrototype );

  return null;
}

// //
//
// /**
//  * Does srcProto has insProto as prototype.
//  * @param {object} srcProto - proto stack to investigate.
//  * @param {object} insProto - proto to look for.
//  * @function hasPrototype
//  * @namespace Tools.prototype
//  */
//
// function hasPrototype( srcProto, insProto )
// {
//
//   while( srcProto !== null )
//   {
//     if( srcProto === insProto )
//     return true;
//     srcProto = Object.getPrototypeOf( srcProto );
//   }
//
//   return false;
// }

//

function has( superPrototype, subPrototype ) /* xxx : move */
{
  _.assert( arguments.length === 2, 'Expects two arguments' );
  // eslint-disable-next-line no-prototype-builtins
  return _.prototype.isPrototypeOf( subPrototype, superPrototype );
}

//

/**
 * Is prototype.
 * @function is
 * @param {object} src - entity to check
 * @namespace Tools
 */

function is( src ) /* xxx : move */
{
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.primitiveIs( src ) )
  return false;
  if( _.routineIs( src ) )
  return false;
  return Object.hasOwnProperty.call( src, 'constructor' );
}

// --
// extension
// --

var Extension =
{

  of : _of,
  each,
  isPrototypeOf,
  havingProperty,

  // hasPrototype,
  hasPrototype : has, /* xxx : remove */
  has,
  is,

}

//

var ExtensionTools =
{

  // prototypeIsPrototypeOf : isPrototypeOf,  /* xxx : remove */
  // prototypeHas : has, /* xxx : remove */
  prototypeIs : is

}

//

Object.assign( Self, Extension );
Object.assign( _, ExtensionTools );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();