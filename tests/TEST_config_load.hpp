/**
 * @file    TEST_cofig_load.hpp
 * @version 0.0.1
 * @date    Thu, 04 Dec 2025 16:15:17 +0000
 * @info    ...
 */
#ifndef _TEST_cofig_load_HPP_
#define _TEST_cofig_load_HPP_

#include <iostream>
#include <cppunit/extensions/HelperMacros.h>
#include <cppunit/TestFixture.h>

/**
  * @brief class TEST_cofig_load
  */
class TEST_config_load
{
public:
	CPPUNIT_TEST_SUITE( TEST_confif_load );
    CPPUNIT_TEST( void TEST_load );
    CPPUNIT_TEST_SUITE_END();

	/**
	* @brief : default ctor
	*/
	TEST_config_load();

		/**
	* @brief : copy ctor
	*/
	TEST_config_load( const TEST_config_load& src );

		/**
	* @brief : destructor
	*/
	virtual ~TEST_config_load();



public:
    void setUp() override;
    void tearDown() override;

protected:

	void TEST_load();

private:

};

#endif
