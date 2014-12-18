#include "systemc.h"

SC_MODULE(monitor){
sc_in<sc_int<16>> m_1, m_2;
sc_in<bool> m_3, m_4, m_5;

void prc_monitor();

SC_CTOR(monitor){
    SC_METHOD(prc_monitor);
    sensitive<<m_1;
    sensitive<<m_2;
    sensitive<<m_3;
    sensitive<<m_4;
	sensitive<<m_5;

}
};