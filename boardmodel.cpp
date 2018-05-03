#include "boardmodel.h"

BoardModel::BoardModel(QObject *parent):QAbstractTableModel(parent)
{
    for (int i = 0; i < 8; ++i){
        for(int j = 0; j < 8; ++j){
            if((i+j) % 2 == 0 && i < 3){
                this->fields[i][j] = BlackPawn;
            }else if((i+j) % 2 == 0 && i > 4){
                this->fields[i][j] = WhitePawn;
            }else if((i+j) % 2 == 0){
                this->fields[i][j] = Empty;
            }else{
                this->fields[i][j] = Unused;
            }

            this->canMove[i][j] = false;
        }
    }

    this->roleNames();
}

bool BoardModel::isBlackField(int row, int col)
{
    return (row + col) % 2 == 0;
}

int BoardModel::rowCount(const QModelIndex &parent) const
{
    return 8;
}

int BoardModel::columnCount(const QModelIndex &parent) const
{
    return 8;
}

QVariant BoardModel::data(const QModelIndex &index, int role) const
{
    QVariant v = QVariant::fromValue(this->fields[index.row()][index.column()]);
    return v;
}
