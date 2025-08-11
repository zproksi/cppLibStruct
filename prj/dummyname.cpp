#include "dummyname.h"

namespace outer
{
namespace inner
{

DummyName::DummyName()
    : member_{7}
{

}

int DummyName::member() {
    return member_;
}


};// namespace inner
};// namespace outer
