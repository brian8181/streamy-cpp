/**
 * @file    TEST_config_load.hpp
 * @version 0.0.1
 * @date    Thu, 04 Dec 2025 16:15:17 +0000
 * @info    ...
 */
#include "TEST_config.hpp"
#include "streamy.hpp"


CPPUNIT_TEST_SUITE_REGISTRATION( TEST_config );

void TEST_config::setUp()
{

}

void TEST_config::tearDown()
{

}

void TEST_config::TEST_config_load()
{
    streamy strmy;
    strmy.load_config("test/config/config");
    map<string, map<string, string>>& config = strmy.get_map_config_sections();
}
