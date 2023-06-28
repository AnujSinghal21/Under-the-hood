#include <fstream>
using namespace std;
int main(){
    ifstream input;
    input.open("states_compile.txt");
    ofstream output;
    output.open("code.txt");
    int s, r, i = 0;
    while(i < 1332 && input){
        i++;
        input >> s;
        input >> r;
        output << "\tbeq $t8, " << s << ", response_" << r << endl;
    }
    input.close();
    output.close();
    return 0;
}