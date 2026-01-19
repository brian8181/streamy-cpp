/**
 * @file    TEST_cofig_load.hpp
 * @version 0.0.1
 * @date    Thu, 04 Dec 2025 16:15:17 +0000
 * @info    ...
 */
#ifndef _TEST_config_HPP_
#define _TEST_config_HPP_

#include <cppunit/extensions/HelperMacros.h>
#include <cppunit/TestFixture.h>
#include <iostream>

/**
  * @brief class TEST_cofig_load
  */
class TEST_config : public CppUnit::TestFixture
{
public:
	CPPUNIT_TEST_SUITE( TEST_config );
	CPPUNIT_TEST( TEST_config_load );
	CPPUNIT_TEST_SUITE_END();


public:
    void setUp();
    void tearDown();

protected:
	void TEST_config_load();

private:

};

#endif
