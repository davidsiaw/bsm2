#include <iostream>
#include <iomanip>
#include <fstream>

int main()
{
    int bytecount = 0;

    std::cout << ";";

    do
    {
        unsigned char c = std::cin.get();

        if (!std::cin.good())
        {
            break;
        }

        std::cout << " " << std::setw(2) << std::setfill('0') << std::hex << (int)c;
        bytecount++;

        if (bytecount % 16 == 0)
        {
            std::cout << "\n;";
        }
        else if (bytecount % 4 == 0)
        {
            std::cout << " ";
        }
    } while (std::cin.good());

    std::cout << "\nTotal bytes: " << bytecount << std::endl;

    return EXIT_SUCCESS;
}
