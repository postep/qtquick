#ifndef FIELDSTATE_H
#define FIELDSTATE_H


#include <QMetaType>
enum FieldState {Empty, WhitePawn, BlackPawn, WhiteQueen, BlackQueen, Unused};

Q_DECLARE_METATYPE(FieldState)


#endif // FIELDSTATE_H
