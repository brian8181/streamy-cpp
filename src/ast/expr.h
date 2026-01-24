/**
 * @file    expr.hpp
 * @version 0.0.1
 * @date    Thu, Oct 30, 2025  4:59:12 PM
 */
#ifndef _expr_HPP_
#define _expr_HPP_

#include <iostream>

using std::cout;
using std::endl;

namespace ast
{
	/**
	 * @class expr
	 */
	class expr
	{
	public:
		/**
		 * @brief : default ctor
		 */
		expr() = default;

		/**
		 * @brief copy ctor
		 * @param const symbol_expr& src, source copy
		 */
		expr( const expr& src ) = default;

		/**
		 * @brief destructor
		 */
		virtual ~expr() = default;

		/**
		 * @brief evaluate
		 * @return variant&
		 */
		 //virtual variant* evaluate( );

		 /**
		  * @brief  T* eval
		  * @return T*
		  */
		  template< typename T >
		  T* eval();


	 protected:
		 void* _val;
	 };

	/**
	 * @class expr
	 */
	template< class T >
	class urnary_expr : expr
	{
	public:
		/**
		 * @brief : default ctor
		 */
		urnary_expr(const T& val) : _val_t(0)
		{
			expr::_val = new T(val);
			_val_t = (T*)expr::_val;
		}

		~urnary_expr()
		{
			delete _val_t;
		}

		T* eval()
		{
			return _val_t;
		}

	 protected:
		T* _val_t;
	 };



	/**
	 * @class expr
	 */
	template< class T >
	class literal_expr : urnary_expr<T>
	{
	public:
		/**
		 * @brief : default ctor
		 */
		literal_expr(T val) : urnary_expr<T>(val)
		{
		}

		~literal_expr()
		{
			delete urnary_expr<T>::_val_t;
		}
	 };


	 /**
	 * @class expr
	 */
	template< class T >
	class binary_expr : expr
	{
	public:
		/**
		 * @brief : default ctor
		 */
		binary_expr(const T& lhs, const T& rhs) //: _lhs(&lhs), _rhs(&rhs)
		{
			_lhs = new T(lhs);
			_rhs = new T(rhs);
		}

		~binary_expr()
		{
			// let consumer free/release/delete
			// delete _lhs;
			// delete _rhs;
		}

	 public:
		 void* _val;
		 T* _lhs;
		 T* _rhs;
	 };

	 template< class T >
	 class add_expr : binary_expr<T>
	 {
	public:
		add_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };


}
#endif
