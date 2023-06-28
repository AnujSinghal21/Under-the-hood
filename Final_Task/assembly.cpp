// C++ program to find the next optimal move for
// a player
#include<bits/stdc++.h>
using namespace std;

struct Move
{
	int row, col;
};
char player = 'o', opponent = 'x';
bool isMovesLeft(char board[3][3])
{
	for (int i = 0; i<3; i++)
		for (int j = 0; j<3; j++)
			if (board[i][j]=='_')
				return true;
	return false;
}
int evaluate(char b[3][3])
{
	for (int row = 0; row<3; row++)
	{
		if (b[row][0]==b[row][1] &&
			b[row][1]==b[row][2])
		{
			if (b[row][0]==player)
				return +10;
			else if (b[row][0]==opponent)
				return -10;
		}
	}
	for (int col = 0; col<3; col++)
	{
		if (b[0][col]==b[1][col] &&
			b[1][col]==b[2][col])
		{
			if (b[0][col]==player)
				return +10;

			else if (b[0][col]==opponent)
				return -10;
		}
	}
	if (b[0][0]==b[1][1] && b[1][1]==b[2][2])
	{
		if (b[0][0]==player)
			return +10;
		else if (b[0][0]==opponent)
			return -10;
	}
	if (b[0][2]==b[1][1] && b[1][1]==b[2][0])
	{
		if (b[0][2]==player)
			return +10;
		else if (b[0][2]==opponent)
			return -10;
	}
	return 0;
}
int minimax(char board[3][3], int depth, bool isMax)
{
	int score = evaluate(board);
	if (score == 10)
		return score;
	if (score == -10)
		return score;
	if (isMovesLeft(board)==false)
		return 0;
	if (isMax)
	{
		int best = -1000;
		for (int i = 0; i<3; i++)
		{
			for (int j = 0; j<3; j++)
			{
				if (board[i][j]=='_')
				{
					board[i][j] = player;
					best = max( best,
						minimax(board, depth+1, !isMax) );
					board[i][j] = '_';
				}
			}
		}
		return best;
	}
	else
	{
		int best = 1000;
		for (int i = 0; i<3; i++)
		{
			for (int j = 0; j<3; j++)
			{
				if (board[i][j]=='_')
				{
					board[i][j] = opponent;
					best = min(best,
						minimax(board, depth+1, !isMax));
					board[i][j] = '_';
				}
			}
		}
		return best;
	}
}
Move findBestMove(char board[3][3])
{
	int bestVal = -1000;
	Move bestMove;
	bestMove.row = -1;
	bestMove.col = -1;
	for (int i = 0; i<3; i++)
	{
		for (int j = 0; j<3; j++)
		{
			if (board[i][j]=='_')
			{
				board[i][j] = player;
				int moveVal = minimax(board, 0, false);
				board[i][j] = '_';
				if (moveVal > bestVal)
				{
					bestMove.row = i;
					bestMove.col = j;
					bestVal = moveVal;
				}
			}
		}
	}
	return bestMove;
}
int response(char board[3][3], int cs){
	for (int i=0;i<3;i++){
		for (int j = 0; j<3;j++){
			board[i][j] = '_';
		}
	}
	int k=0, pos, r,c;
	while(cs!=0){
		pos = cs%10 - 1;
		if (k%2==0){
			board[pos/3][pos%3] = 'x';
		}else{
			board[pos/3][pos%3] = 'o';
		}
		cs/= 10;
		k++;
	}
	Move best = findBestMove(board);
	return 3 * best.row + best.col + 1;
}
int can_append(int cs, int pos){
	while (cs!=0){
		if (cs%10 == pos){
			return 0;
		}
		cs/= 10;
	}
	return 1;
}

int main()
{
	char board[3][3] =
	{
		{ '_', '_', '_' },
		{ '_', '_', '_' },
		{ '_', '_', '_' }
	};
    Move bestMove;
	ofstream output;
    output.open("states_compile.txt");
	vector<int> cs1;
	vector<int> s1;
	vector<int> r1;
	for (int i=1;i<10;i++){
		s1.push_back(i);
		cs1.push_back(i);
	}
	for (int i=0; i<cs1.size(); i++){
		r1.push_back(response(board, cs1[i]));
		cs1[i] = cs1[i]*10 + r1[i];
	}
	for (int i=0; i< r1.size(); i++){
		output << s1[i] << " " << r1[i] << endl;
	}
	vector<int> cs2;
	vector<int> s2;
	vector<int> r2;
	for (int i=0; i<cs1.size(); i++){
		for (int j=1; j<10;j++){
			if (can_append(cs1[i], j)){
				s2.push_back(10*s1[i] + j);
				cs2.push_back(10*cs1[i] + j);
			}
		}
	}
	for (int i=0; i<cs2.size(); i++){
		r2.push_back(response(board, cs2[i]));
		cs2[i] = cs2[i]*10 + r2[i];
	}
	for (int i=0; i< r2.size(); i++){
		output << s2[i] << " " << r2[i] << endl;
	}
	vector<int> cs3;
	vector<int> s3;
	vector<int> r3;
	for (int i=0; i<cs2.size(); i++){
		for (int j=1; j<10;j++){
			if (can_append(cs2[i], j)){
				s3.push_back(10*s2[i] + j);
				cs3.push_back(10*cs2[i] + j);
			}
		}
	}
	for (int i=0; i<cs3.size(); i++){
		r3.push_back(response(board, cs3[i]));
		cs3[i] = cs3[i]*10 + r3[i];
	}
	for (int i=0; i< r3.size(); i++){
		output << s3[i] << " " << r3[i] << endl;
	}

	vector<int> cs4;
	vector<int> s4;
	vector<int> r4;
	for (int i=0; i<cs3.size(); i++){
		for (int j=1; j<10;j++){
			if (can_append(cs3[i], j)){
				s4.push_back(10*s3[i] + j);
				cs4.push_back(10*cs3[i] + j);
			}
		}
	}
	for (int i=0; i<cs4.size(); i++){
		r4.push_back(response(board, cs4[i]));
		cs4[i] = cs4[i]*10 + r4[i];
	}
	for (int i=0; i< r4.size(); i++){
		output << s4[i] << " " << r4[i] << endl;
	}
	output.close();
    return 0;
}
