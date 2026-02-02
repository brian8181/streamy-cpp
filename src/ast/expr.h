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
		struct expr_node
		{
			void* pval;
			expr_node* next;
			expr_node* nodes;
		};

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

		binary_expr(const expr& lhs, const T& rhs) //: _lhs(&lhs), _rhs(&rhs)
		{
			_lhs = new T(lhs);
			_rhs = new T(rhs);
		}

		binary_expr(const expr& lhs, const expr& rhs) //: _lhs(&lhs), _rhs(&rhs)
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

		add_expr(const add_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };


	 template< class T >
	 class add_expr : binary_expr<T>
	 {
	public:
		add_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		add_expr(const add_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };

	 template< class T >
	 class subtract_expr : binary_expr<T>
	 {
	public:
		subtract_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		subtract_expr(const subtract_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };
	 template< class T >
	 class multiply_expr : binary_expr<T>
	 {
	public:
		multiply_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		multiply_expr(const multiply_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };

	 template< class T >
	 class divide_expr : binary_expr<T>
	 {
	public:
		divide_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		divide_expr(const divide_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };


	 template< class T >
	 class modlus_expr : binary_expr<T>
	 {
	public:
		modlus_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		modlus_expr(const modlus_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };

	 template< class T >
	 class assign_expr : binary_expr<T>
	 {
	public:
		assign_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		assign_expr(const assign_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };

	 template< class T >
	 class equal_expr : binary_expr<T>
	 {
	public:
		equal_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		equal_expr(const equal_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };


	 template< class T >
	 class less_than_expr : binary_expr<T>
	 {
	public:
		less_than(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		less_than(const less_than<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };


	 	 template< class T >
	 class less_than_equal_expr : binary_expr<T>
	 {
	public:
		less_than(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		less_than(const less_than<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };

	 template< class T >
	 class greater_than_expr : binary_expr<T>
	 {
	public:
		add_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		add_expr(const add_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };


	 	 template< class T >
	 class greater_than_equal_expr : binary_expr<T>
	 {
	public:
		add_expr(const T& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}

		add_expr(const add_expr<T>& lhs, const T& rhs) : binary_expr<T>(lhs, rhs)
		{

		}
	 };



template <typename T>
class SinglyLinkedList
{
public:

	struct Node
	{
		T data;
		Node *next;
	};

public:
    SinglyLinkedList() {};
    SinglyLinkedList(const Node* _head) {};
    ~SinglyLinkedList() {};
private:
    Node* mHead;
};



}
#endif
