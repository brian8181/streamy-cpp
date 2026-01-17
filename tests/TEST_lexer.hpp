/**
 * @file    TEST_lexer.hpp
 * @version 0.0.1
 * @date    Thu, 04 Dec 2025 16:15:17 +0000
 * @info    ...
 */
#ifndef _TEST_lexer_HPP_
#define _TEST_lexer_HPP_

#include <cppunit/extensions/HelperMacros.h>
#include <cppunit/TestFixture.h>
#include <iostream>

/**
  * @brief class TEST_lexer
  */
class TEST_lexer : public CppUnit::TestFixture
{
public:
	CPPUNIT_TEST_SUITE( TEST_lexer );
	CPPUNIT_TEST( TEST_lexer_load );
	CPPUNIT_TEST_SUITE_END();


public:
    void setUp();
    void tearDown();

protected:
	void TEST_lexer_load();

private:

};

#endif
