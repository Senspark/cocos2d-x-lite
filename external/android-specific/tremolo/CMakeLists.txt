cmake_minimum_required( VERSION 3.6 )

set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DONLY_C -O2 -DANDROID_ARM_MODE=arm")

set (TREMOLO_SRC
  ${CMAKE_CURRENT_LIST_DIR}/Tremolo/bitwise.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/codebook.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/dsp.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/floor0.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/floor1.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/floor_lookup.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/framing.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/mapping0.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/mdct.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/misc.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/res012.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/treminfo.c
	${CMAKE_CURRENT_LIST_DIR}/Tremolo/vorbisfile.c
)

include_directories(
  ${CMAKE_CURRENT_LIST_DIR}/Tremolo/
)

add_library(tremolo STATIC ${TREMOLO_SRC})

set_target_properties(tremolo
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
)
