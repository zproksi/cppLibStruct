#pragma once

namespace outer
{
namespace inner
{
/// @brief Set Your Description
class DummyName
{
private:
    /// @brief  no copy, no move; feel free to set your own approach
    DummyName(const DummyName&) = delete;
    DummyName(DummyName&&) = delete;
    DummyName& operator =(const DummyName&) = delete;
    DummyName&& operator =(DummyName&&) = delete;
public:

    /// @brief this is constructor to change/implement
    DummyName();

    /// @brief Trivial Destructor; set it virtual if your class has virtual methods
    ~DummyName() = default;

    /// @brief provide your public API first so everybody will know your logic
    /// @return member_ for test purposes
    int member();

protected:
    int member_ = 7; /// @brief dummy value for having some logic and tests
};

};// namespace inner
};// namespace outer

