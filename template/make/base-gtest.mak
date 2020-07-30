# 下記ディレクトリ構成でプロジェクトを作る場合の Makefile
# TODO: オブジェクト・実行ファイルを ./build に格納するようにしたい
#
# ```
# project_dir/
#   +- include/ : ヘッダファイル
#   +- src/     : ソースコード
#   +- test/    : テストコード
# ```
SRCS = <`1:SRCS`>
TEST_SRCS = <`2:TEST_SRCS`>
CFLAGS = ./include
LIBS = <`3:LIBS`>
TARGET = <`4:EXECUTABLE_FILE_NAME`>
OBJS = $(subst .c,.o,$(SRCS))

ifeq ($(OS),Windows_NT)
TARGET := $(TARGET).exe
endif

TEST_OBJS = $(OBJS:.o=.gcovo) $(subst .cpp,.gcovo,$(TEST_SRCS))
TEST_CFLAGS = $(CFLAGS)
TEST_LIBS = $(LIBS) -lgtest -lgtest_main -lgcov
TEST_TARGET = test_$(TARGET)

.SUFFIXES: .c .cpp .o .gcovo

all : test $(TARGET)
test : $(TEST_TARGET)
	./$(TEST_TARGET)

$(TARGET) : $(OBJS)
	gcc $(OBJS) $(LIBS) -o $@

$(TEST_TARGET) : $(TEST_OBJS:.o=.gcovo)
	g++ $(filter-out ./src/main.gcovo, $(TEST_OBJS)) $(TEST_LIBS) -o $@

.c.o :
	gcc -c $(CFLAGS) -I. $< -o $@

.c.gcovo :
	gcc --coverage -c $(CFLAGS) -I. $< -o $@

.cpp.gcovo :
	g++ --coverage -c $(TEST_CFLAGS) -I. $< -o $@

clean :
	rm -f **/*.o *.gcov **/*.cda **/*.gcno **/*.gcovo $(TARGET) $(TEST_TARGET)

