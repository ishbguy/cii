# $(I)d$
PROJECT = cii
MAJORVERSION = 2
A = .a
O = .o
SO = .so
E = 
CC = cc
I = include
CFLAGS = -c -g -I$(I)
LDFLAGS = -g
LD = cc
AS = as
AR = ar ruv
RANLIB = ranlib
RM = rm -f
B = $(BUILDDIR)
CUSTOM = custom.mk
include $(CUSTOM)
MODULES = ap arena arith array assert atom bit except fmt \
		  list mem mp ring seq set stack str table text xp
EXTRAS = memcmp memmove strncmp
EXAMPLES = double calc ids mpcalc wf xref cref iref kref \
		   idents words basename dirname
THREADS = thread swtch chan
THREADS_EXAMPLES = sort spin sieve
TOOL = maxalign

LIB_AR = lib$(PROJECT)$(A)
LIB_SHARE = lib$(PROJECT)$(SO).$(MAJORVERSION)
MODULES_OBJS = $(addsuffix $(O), $(addprefix $(B), $(MODULES)))
EXTRAS_OBJS = $(addsuffix $(O), $(addprefix $(B), $(EXTRAS)))
EXAMPLES_BIN = $(addsuffix $(E), $(addprefix $(B), $(EXAMPLES)))
THREADS_OBJS = $(addsuffix $(O), $(addprefix $(B), $(THREADS)))
THREADS_EXAMPLES_BIN = $(addsuffix $(E), $(addprefix $(B), $(THREADS_EXAMPLES)))
TOOL_BIN = $(addsuffix $(E), $(addprefix $(B), $(TOOL)))

# Add source and header files in path
vpath %.c src/
vpath %.s src/
vpath %.c examples/
vpath %.c misc/
vpath %.h include/
vpath %.h examples/

.PHONY : all
all : lib

.PHONY : lib
lib : $(LIB_AR)
$(LIB_AR) : $(MODULES_OBJS) $(EXTRAS_OBJS)
	$(AR) $@ $^; $(RANLIB) $@ || true

.PHONY : example
example : $(EXAMPLES_BIN)

.PHONY : thread
thread : $(THREADS_EXAMPLES_BIN)
$(THREADS_EXAMPLES_BIN) : $(THREADS_OBJS)

# Linux-specific rule for building a shared library
ifneq "$(MAKECMDGOAL)" "share"
CFLAGS += -fPIC
endif
.PHONY : share
share : $(LIB_SHARE)
$(LIB_SHARE): $(MODULES_OBJS) $(EXTRAS_OBJS)
	$(CC) -shared -Wl,-soname,$(LIB_SHARE) -o $@ $^

%$(O) : %.c
	$(CC) $(CFLAGS) -o $@ $<

$(B)swtch$(O) : swtch.s; $(AS) -o $@ $<

$(B)double$(E) : $(B)double$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)calc$(E) : $(B)calc$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)ids$(E) : $(B)ids$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)mpcalc$(E) : $(B)mpcalc$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)iref$(E) : $(B)iref$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)kref$(E) : $(B)kref$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)idents$(E) : $(B)idents$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)words$(E) : $(B)words$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)basename$(E) : $(B)basename$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)dirname$(E) : $(B)basename$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)wf$(E) : $(B)wf$(O) $(B)getword$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)xref$(E) : $(B)xref$(O) $(B)getword$(O) $(LIB_AR);$(LD) $(LDFLAGS) -o $@ $^
$(B)cref$(E) : $(B)cref$(O) $(B)integer$(O) $(LIB_AR);$(LD) $(LDFLAGS) -o $@ $^
$(B)sort$(E) : $(B)sort$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)spin$(E) : $(B)spin$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^
$(B)sieve$(E) : $(B)sieve$(O) $(LIB_AR); $(LD) $(LDFLAGS) -o $@ $^

.PHONY : tool
tool : $(TOOL_BIN)
$(TOOL_BIN) : maxalign.c
	$(CC) -o $@ $<

.PHONY : clean
clean :
	$(RM) $(B)*$(O)
	$(RM) $(EXAMPLES_BIN) $(THREADS_EXAMPLES_BIN) $(TOOL_BIN)

.PHONY : clobber
clobber : clean
	$(RM) $(LIB_AR) $(LIB_SHARE)

# DO NOT DELETE THIS LINE -- make depend depends on it.

$(B)ap$(O) : assert.h except.h ap.h fmt.h xp.h mem.h
$(B)arena$(O) : assert.h except.h arena.h
$(B)arith$(O) : arith.h
$(B)array$(O) : assert.h except.h array.h arrayrep.h mem.h
$(B)assert$(O) : assert.h except.h
$(B)atom$(O) : atom.h assert.h except.h mem.h
$(B)bit$(O) : assert.h except.h bit.h mem.h
$(B)chan$(O) : assert.h except.h mem.h chan.h sem.h
$(B)except$(O) : assert.h except.h
$(B)fmt$(O) : assert.h except.h fmt.h mem.h
$(B)list$(O) : assert.h except.h mem.h list.h
$(B)mem$(O) : assert.h except.h mem.h
$(B)memchk$(O) : assert.h except.h mem.h
$(B)mp$(O) : assert.h except.h fmt.h mem.h xp.h mp.h
$(B)ring$(O) : assert.h except.h ring.h mem.h
$(B)seq$(O) : assert.h except.h seq.h array.h arrayrep.h mem.h
$(B)set$(O) : mem.h except.h assert.h arith.h set.h
$(B)stack$(O) : assert.h except.h mem.h stack.h
$(B)str$(O) : assert.h except.h fmt.h str.h mem.h
$(B)table$(O) : mem.h except.h assert.h table.h
$(B)text$(O) : assert.h except.h fmt.h text.h mem.h
$(B)thread$(O) : assert.h except.h mem.h thread.h sem.h
$(B)thread-nt$(O) : assert.h except.h mem.h thread.h sem.h
$(B)xp$(O) : assert.h except.h xp.h
$(B)wf$(O) $(B)xref$(O) $(B)getword$(O) : getword.h
$(B)cref$(O) $(B)integer$(O) : integer.h
