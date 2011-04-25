local ffi = require "ffi"
require "luxinia2.luxplatform"
require "glewgl"

ffi.cdef [[
// lxg | Lux Graphics
typedef struct lxgContext_s* lxgContextPTR;
typedef struct lxgBuffer_s* lxgBufferPTR;
typedef struct lxgStreamHost_s* lxgStreamHostPTR;
typedef struct lxgVertexDecl_s* lxgVertexDeclPTR;
typedef struct lxgVertexPointer_s* lxgVertexPointerPTR;
typedef struct lxgVertexElement_s* lxgVertexElementPTR;
typedef struct lxgVertexState_s* lxgVertexStatePTR;
typedef struct lxgFeedbackState_s* lxgFeedbackStatePTR;

typedef struct lxgTextureImage_s* lxgTextureImagePTR;
typedef struct lxgSampler_s* lxgSamplerPTR;
typedef struct lxgTexture_s* lxgTexturePTR;
typedef struct lxgRenderBuffer_s* lxgRenderBufferPTR;
typedef struct lxgTextureUpdate_s* lxgTextureUpdatePTR;

typedef struct lxgProgramParameter_s* lxgProgramParameterPTR;
typedef struct lxgDomainProgram_s* lxgDomainProgramPTR;
typedef struct lxgProgram_s* lxgProgramPTR;
typedef struct lxgProgramData_s* lxgProgramDataPTR;

typedef struct lxgRenderTarget_s* lxgRenderTargetPTR;
typedef struct lxgViewPort_s* lxgViewPortPTR;
typedef struct lxgViewPortMrt_s* lxgViewPortMrtPTR;
typedef struct lxgFrameBounds_s* lxgFrameBoundsPTR;
typedef struct lxgRenderAssign_s* lxgRenderAssignPTR;

typedef struct lxgBlendMrt_s* lxgBlendMrtPTR;
typedef struct lxgBlend_s* lxgBlendPTR;
typedef struct lxgStencil_s* lxgStencilPTR;
typedef struct lxgLogic_s* lxgLogicPTR;
typedef struct lxgDepth_s* lxgDepthPTR;
typedef flags32 lxgRenderFlag_t;

typedef enum lxgCompareMode_e{
  LUXGFX_COMPARE_NEVER,
  LUXGFX_COMPARE_LESS,
  LUXGFX_COMPARE_EQUAL,
  LUXGFX_COMPARE_LEQUAL,
  LUXGFX_COMPARE_GREATER,
  LUXGFX_COMPARE_NOTEQUAL,
  LUXGFX_COMPARE_GEQUAL,
  LUXGFX_COMPARE_ALWAYS,
  LUXGFX_COMPARE_DONTEXECUTE,
  LUXGFX_COMPARE_ILLEGAL,
}lxGLCompareMode_t;

typedef enum lxgAccessMode_e{
  LUXGFX_ACCESS_READ,
  LUXGFX_ACCESS_WRITE,
  LUXGFX_ACCESS_READWRITE,

  LUXGFX_ACCESS_WRITEDISCARD,
  LUXGFX_ACCESS_WRITEDISCARDALL,

  LUXGFX_ACCESSES,
}lxgAccessMode_t;

  enum{
    LUXGFX_MAX_TEXTURE_IMAGES = 32,
    LUXGFX_MAX_RENDERTARGETS =     16,
    LUXGFX_MAX_RWTEXTURE_IMAGES =  8,
    LUXGFX_MAX_UNIFORM_BUFFERS =   (12*5),
    LUXGFX_MAX_TEXTURE_MIPMAPS = 16,
    LUXGFX_MAX_VERTEX_STREAMS  = 8,
  };
  
  typedef enum lxGLCompareMode_e{
    LUXGL_COMPARE_NEVER = GL_NEVER,
    LUXGL_COMPARE_LESS = GL_LESS,
    LUXGL_COMPARE_EQUAL = GL_EQUAL,
    LUXGL_COMPARE_LEQUAL = GL_LEQUAL,
    LUXGL_COMPARE_GREATER = GL_GREATER,
    LUXGL_COMPARE_NOTEQUAL = GL_NOTEQUAL,
    LUXGL_COMPARE_GEQUAL = GL_GEQUAL,
    LUXGL_COMPARE_ALWAYS = GL_ALWAYS,
    LUXGL_COMPARE_DONTEXECUTE = 0xFFFFFFFFu,
  }lxGLCompareMode_t;

  typedef enum lxGLStencilMode_e{
    LUXGL_STENCIL_KEEP = GL_KEEP,
    LUXGL_STENCIL_ZERO = GL_ZERO,
    LUXGL_STENCIL_REPLACE = GL_REPLACE,
    LUXGL_STENCIL_INCR_SAT = GL_INCR,
    LUXGL_STENCIL_DECR_SAT = GL_DECR,
    LUXGL_STENCIL_INVERT = GL_INVERT,
    LUXGL_STENCIL_INCR = GL_INCR_WRAP,
    LUXGL_STENCIL_DECR = GL_DECR_WRAP,
  }lxGLStencilMode_t;

  typedef enum lxGLBlendWeight_e{
    LUXGL_BLENDW_ZERO = GL_ZERO,
    LUXGL_BLENDW_ONE = GL_ONE,
    LUXGL_BLENDW_RGB_SRC = GL_SRC_COLOR,
    LUXGL_BLENDW_RGB_DST = GL_DST_COLOR,
    LUXGL_BLENDW_A_SRC = GL_SRC_ALPHA,
    LUXGL_BLENDW_A_DST = GL_DST_ALPHA,
    LUXGL_BLENDW_INVRGB_SRC = GL_ONE_MINUS_SRC_COLOR,
    LUXGL_BLENDW_INVRGB_DST = GL_ONE_MINUS_DST_COLOR,
    LUXGL_BLENDW_INVA_SRC = GL_ONE_MINUS_SRC_ALPHA,
    LUXGL_BLENDW_INVA_DST = GL_ONE_MINUS_DST_ALPHA,
    LUXGL_BLENDW_UNKOWN = 0xFFFFABCD,
  }lxGLBlendWeight_t;

  typedef enum lxGLBlendEquation_e{
    LUXGL_BLENDE_ADD = GL_FUNC_ADD,
    LUXGL_BLENDE_SUB = GL_FUNC_SUBTRACT,
    LUXGL_BLENDE_SUB_REV = GL_FUNC_REVERSE_SUBTRACT,
    LUXGL_BLENDE_MIN = GL_MIN,
    LUXGL_BLENDE_MAX = GL_MAX,
    LUXGL_BLENDE_UNKOWN = 0xFFFFABCD,
  }lxGLBlendEquation_t;

  typedef enum lxGLLogicOp_e{
    LUXGL_LOGICOP_CLEAR = GL_CLEAR,
    LUXGL_LOGICOP_SET = GL_SET,
    LUXGL_LOGICOP_COPY = GL_COPY,
    LUXGL_LOGICOP_INVERTED = GL_COPY_INVERTED,
    LUXGL_LOGICOP_NOOP = GL_NOOP,
    LUXGL_LOGICOP_INVERT = GL_INVERT,
    LUXGL_LOGICOP_AND = GL_AND,
    LUXGL_LOGICOP_NAND = GL_NAND,
    LUXGL_LOGICOP_OR = GL_OR,
    LUXGL_LOGICOP_NOR = GL_NOR,
    LUXGL_LOGICOP_XOR = GL_XOR,
    LUXGL_LOGICOP_EQUIV = GL_EQUIV,
    LUXGL_LOGICOP_AND_REVERSE = GL_AND_REVERSE,
    LUXGL_LOGICOP_AND_INVERTED = GL_AND_INVERTED,
    LUXGL_LOGICOP_OR_REVERSE = GL_OR_REVERSE,
    LUXGL_LOGICOP_OR_INVERTED = GL_OR_INVERTED,
    LUXGL_LOGICOP_ILLEGAL = 0,
  }lxGLLogicOp_t;

  typedef enum lxGLPrimitiveType_e{
    LUXGL_POINTS = GL_POINTS,
    LUXGL_TRIANGLES = GL_TRIANGLES,
    LUXGL_TRIANGLE_STRIP = GL_TRIANGLE_STRIP,
    LUXGL_TRIANGLE_FAN = GL_TRIANGLE_FAN,
    LUXGL_LINES = GL_LINES,
    LUXGL_LINE_LOOP = GL_LINE_LOOP,
    LUXGL_LINE_STRIP = GL_LINE_STRIP,
    LUXGL_QUADS = GL_QUADS,
    LUXGL_QUAD_STRIP = GL_QUAD_STRIP,
    LUXGL_LINE_ADJ = GL_LINES_ADJACENCY,
    LUXGL_LINE_STRIP_ADJ = GL_LINE_STRIP_ADJACENCY,
    LUXGL_TRIANGLE_STRIP_ADJ = GL_TRIANGLE_STRIP_ADJACENCY,
    LUXGL_TRIANGLE_ADJ = GL_TRIANGLES_ADJACENCY,
    LUXGL_PATCHES = GL_PATCHES,
    LUXGL_POLYGON = GL_POLYGON,
  }lxGLPrimitiveType_t;

  typedef enum  lxGLTextureTarget_e{
    LUXGL_TEXTURE_1D = GL_TEXTURE_1D,
    LUXGL_TEXTURE_2D = GL_TEXTURE_2D,
    LUXGL_TEXTURE_3D = GL_TEXTURE_3D,
    LUXGL_TEXTURE_RECT = GL_TEXTURE_RECTANGLE,
    LUXGL_TEXTURE_1DARRAY = GL_TEXTURE_1D_ARRAY,
    LUXGL_TEXTURE_2DARRAY = GL_TEXTURE_2D_ARRAY,
    LUXGL_TEXTURE_CUBE = GL_TEXTURE_CUBE_MAP,
    LUXGL_TEXTURE_CUBEARRAY = GL_TEXTURE_CUBE_MAP_ARRAY,
    LUXGL_TEXTURE_2DMS = GL_TEXTURE_2D_MULTISAMPLE,
    LUXGL_TEXTURE_2DMSARRAY = GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
    LUXGL_TEXTURE_BUFFER = GL_TEXTURE_BUFFER,
    LUXGL_TEXTURE_RENDERBUFFER = GL_TEXTURE_RENDERBUFFER_NV,
    LUXGL_TEXTURE_INVALID = 0,
  }lxGLTextureTarget_t;

  typedef enum lxGLBufferTarget_e{
    LUXGL_BUFFER_VERTEX = GL_ARRAY_BUFFER,
    LUXGL_BUFFER_INDEX = GL_ELEMENT_ARRAY_BUFFER,
    LUXGL_BUFFER_PIXELWRITE = GL_PIXEL_PACK_BUFFER,
    LUXGL_BUFFER_PIXELREAD = GL_PIXEL_UNPACK_BUFFER,
    LUXGL_BUFFER_UNIFORM = GL_UNIFORM_BUFFER,
    LUXGL_BUFFER_TEXTURE = GL_TEXTURE_BUFFER,
    LUXGL_BUFFER_FEEDBACK = GL_TRANSFORM_FEEDBACK_BUFFER,
    LUXGL_BUFFER_CPYWRITE = GL_COPY_WRITE_BUFFER,
    LUXGL_BUFFER_CPYREAD = GL_COPY_READ_BUFFER,
    LUXGL_BUFFER_DRAWINDIRECT = GL_DRAW_INDIRECT_BUFFER,
    LUXGL_BUFFER_NVVIDEO = 0x9020, //FIXME GL_VIDEO_BUFFER_NV;
    LUXGL_BUFFER_NVPARAM_VERTEX = GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV,
    LUXGL_BUFFER_NVPARAM_GEOMETRY = GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV,
    LUXGL_BUFFER_NVPARAM_FRAGMENT = GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV,
    LUXGL_BUFFER_NVPARAM_TESSCTRL = GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV,
    LUXGL_BUFFER_NVPARAM_TESSEVAL = GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV,
    LUXGL_BUFFER_INVALID = 0,
  }lxGLBufferTarget_t;

  typedef enum lxGLShaderType_e{
    LUXGL_SHADER_VERTEX = GL_VERTEX_SHADER,
    LUXGL_SHADER_FRAGMENT = GL_FRAGMENT_SHADER,
    LUXGL_SHADER_GEOMETRY = GL_GEOMETRY_SHADER,
    LUXGL_SHADER_TESSCTRL = GL_TESS_CONTROL_SHADER,
    LUXGL_SHADER_TESSEVAL = GL_TESS_EVALUATION_SHADER,
  }lxGLShaderType_t;

  typedef enum lxGLProgramType_e{
    LUXGL_PROGRAM_VERTEX = GL_VERTEX_PROGRAM_ARB,
    LUXGL_PROGRAM_FRAGMENT = GL_FRAGMENT_PROGRAM_ARB,
    LUXGL_PROGRAM_GEOMETRY = GL_GEOMETRY_PROGRAM_NV,
    LUXGL_PROGRAM_TESSCTRL = GL_TESS_CONTROL_PROGRAM_NV,
    LUXGL_PROGRAM_TESSEVAL = GL_TESS_EVALUATION_PROGRAM_NV,
  }lxGLProgramType_t;

  typedef enum lxGLParameterType_e{
    LUXGL_PARAM_FLOAT = GL_FLOAT,
    LUXGL_PARAM_FLOAT2 = GL_FLOAT_VEC2,
    LUXGL_PARAM_FLOAT3 = GL_FLOAT_VEC3,
    LUXGL_PARAM_FLOAT4 = GL_FLOAT_VEC4,
    LUXGL_PARAM_INT = GL_INT,
    LUXGL_PARAM_INT2 = GL_INT_VEC2,
    LUXGL_PARAM_INT3 = GL_INT_VEC3,
    LUXGL_PARAM_INT4 = GL_INT_VEC4,
    LUXGL_PARAM_UINT = GL_UNSIGNED_INT,
    LUXGL_PARAM_UINT2 = GL_UNSIGNED_INT_VEC2,
    LUXGL_PARAM_UINT3 = GL_UNSIGNED_INT_VEC3,
    LUXGL_PARAM_UINT4 = GL_UNSIGNED_INT_VEC4,
    LUXGL_PARAM_BOOL = GL_BOOL,
    LUXGL_PARAM_BOOL2 = GL_BOOL_VEC2,
    LUXGL_PARAM_BOOL3 = GL_BOOL_VEC3,
    LUXGL_PARAM_BOOL4 = GL_BOOL_VEC4,
    LUXGL_PARAM_MAT2 = GL_FLOAT_MAT2,
    LUXGL_PARAM_MAT3 = GL_FLOAT_MAT3,
    LUXGL_PARAM_MAT4 = GL_FLOAT_MAT4,
    LUXGL_PARAM_MAT2x3 = GL_FLOAT_MAT2x3,
    LUXGL_PARAM_MAT2x4 = GL_FLOAT_MAT2x4,
    LUXGL_PARAM_MAT3x2 = GL_FLOAT_MAT3x2,
    LUXGL_PARAM_MAT3x4 = GL_FLOAT_MAT3x4,
    LUXGL_PARAM_MAT4x2 = GL_FLOAT_MAT4x2,
    LUXGL_PARAM_MAT4x3 = GL_FLOAT_MAT4x3,

    LUXGL_PARAM_SAMPLER_1D = GL_SAMPLER_1D,
    LUXGL_PARAM_SAMPLER_2D = GL_SAMPLER_2D,
    LUXGL_PARAM_SAMPLER_3D = GL_SAMPLER_3D,
    LUXGL_PARAM_SAMPLER_CUBE = GL_SAMPLER_CUBE,
    LUXGL_PARAM_SAMPLER_2DRECT = GL_SAMPLER_2D_RECT,
    LUXGL_PARAM_SAMPLER_2DMS = GL_SAMPLER_2D_MULTISAMPLE,
    LUXGL_PARAM_SAMPLER_1DARRAY = GL_SAMPLER_1D_ARRAY,
    LUXGL_PARAM_SAMPLER_2DARRAY = GL_SAMPLER_2D_ARRAY,
    LUXGL_PARAM_SAMPLER_CUBEARRAY = GL_SAMPLER_CUBE_MAP_ARRAY,
    LUXGL_PARAM_SAMPLER_2DMSARRAY = GL_SAMPLER_2D_MULTISAMPLE_ARRAY,
    LUXGL_PARAM_SAMPLER_BUFFER = GL_SAMPLER_BUFFER,

    LUXGL_PARAM_ISAMPLER_1D = GL_INT_SAMPLER_1D,
    LUXGL_PARAM_ISAMPLER_2D = GL_INT_SAMPLER_2D,
    LUXGL_PARAM_ISAMPLER_3D = GL_INT_SAMPLER_3D,
    LUXGL_PARAM_ISAMPLER_CUBE = GL_INT_SAMPLER_CUBE,
    LUXGL_PARAM_ISAMPLER_2DRECT = GL_INT_SAMPLER_2D_RECT,
    LUXGL_PARAM_ISAMPLER_2DMS = GL_INT_SAMPLER_2D_MULTISAMPLE,
    LUXGL_PARAM_ISAMPLER_1DARRAY = GL_INT_SAMPLER_1D_ARRAY,
    LUXGL_PARAM_ISAMPLER_2DARRAY = GL_INT_SAMPLER_2D_ARRAY,
    LUXGL_PARAM_ISAMPLER_CUBEARRAY = GL_INT_SAMPLER_CUBE_MAP_ARRAY,
    LUXGL_PARAM_ISAMPLER_2DMSARRAY = GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY,
    LUXGL_PARAM_ISAMPLER_BUFFER = GL_INT_SAMPLER_BUFFER,

    LUXGL_PARAM_USAMPLER_1D = GL_UNSIGNED_INT_SAMPLER_1D,
    LUXGL_PARAM_USAMPLER_2D = GL_UNSIGNED_INT_SAMPLER_2D,
    LUXGL_PARAM_USAMPLER_3D = GL_UNSIGNED_INT_SAMPLER_3D,
    LUXGL_PARAM_USAMPLER_CUBE = GL_UNSIGNED_INT_SAMPLER_CUBE,
    LUXGL_PARAM_USAMPLER_2DRECT = GL_UNSIGNED_INT_SAMPLER_2D_RECT,
    LUXGL_PARAM_USAMPLER_2DMS = GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE,
    LUXGL_PARAM_USAMPLER_1DARRAY = GL_UNSIGNED_INT_SAMPLER_1D_ARRAY,
    LUXGL_PARAM_USAMPLER_2DARRAY = GL_UNSIGNED_INT_SAMPLER_2D_ARRAY,
    LUXGL_PARAM_USAMPLER_CUBEARRAY = GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY,
    LUXGL_PARAM_USAMPLER_2DMSARRAY = GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY,
    LUXGL_PARAM_USAMPLER_BUFFER = GL_UNSIGNED_INT_SAMPLER_BUFFER,

    LUXGL_PARAM_SAMPLER_1D_SHADOW = GL_SAMPLER_1D_SHADOW,
    LUXGL_PARAM_SAMPLER_2D_SHADOW = GL_SAMPLER_2D_SHADOW,
    LUXGL_PARAM_SAMPLER_CUBE_SHADOW = GL_SAMPLER_CUBE_SHADOW,
    LUXGL_PARAM_SAMPLER_2DRECT_SHADOW = GL_SAMPLER_2D_RECT_SHADOW,
    LUXGL_PARAM_SAMPLER_1DARRAY_SHADOW = GL_SAMPLER_1D_ARRAY_SHADOW,
    LUXGL_PARAM_SAMPLER_2DARRAY_SHADOW = GL_SAMPLER_2D_ARRAY_SHADOW,
    LUXGL_PARAM_SAMPLER_CUBEARRAY_SHADOW = GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW,

    LUXGL_PARAM_IMAGE_1D = GL_IMAGE_1D_EXT,
    LUXGL_PARAM_IMAGE_2D = GL_IMAGE_2D_EXT,
    LUXGL_PARAM_IMAGE_3D = GL_IMAGE_3D_EXT,
    LUXGL_PARAM_IMAGE_CUBE = GL_IMAGE_CUBE_EXT,
    LUXGL_PARAM_IMAGE_2DRECT = GL_IMAGE_2D_RECT_EXT,
    LUXGL_PARAM_IMAGE_2DMS = GL_IMAGE_2D_MULTISAMPLE_EXT,
    LUXGL_PARAM_IMAGE_1DARRAY = GL_IMAGE_1D_ARRAY_EXT,
    LUXGL_PARAM_IMAGE_2DARRAY = GL_IMAGE_2D_ARRAY_EXT,
    LUXGL_PARAM_IMAGE_CUBEARRAY = GL_IMAGE_CUBE_MAP_ARRAY_EXT,
    LUXGL_PARAM_IMAGE_2DMSARRAY = GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT,
    LUXGL_PARAM_IMAGE_BUFFER = GL_IMAGE_BUFFER_EXT,

    LUXGL_PARAM_IIMAGE_1D = GL_INT_IMAGE_1D_EXT,
    LUXGL_PARAM_IIMAGE_2D = GL_INT_IMAGE_2D_EXT,
    LUXGL_PARAM_IIMAGE_3D = GL_INT_IMAGE_3D_EXT,
    LUXGL_PARAM_IIMAGE_CUBE = GL_INT_IMAGE_CUBE_EXT,
    LUXGL_PARAM_IIMAGE_2DRECT = GL_INT_IMAGE_2D_RECT_EXT,
    LUXGL_PARAM_IIMAGE_2DMS = GL_INT_IMAGE_2D_MULTISAMPLE_EXT,
    LUXGL_PARAM_IIMAGE_1DARRAY = GL_INT_IMAGE_1D_ARRAY_EXT,
    LUXGL_PARAM_IIMAGE_2DARRAY = GL_INT_IMAGE_2D_ARRAY_EXT,
    LUXGL_PARAM_IIMAGE_CUBEARRAY = GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT,
    LUXGL_PARAM_IIMAGE_2DMSARRAY = GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT,
    LUXGL_PARAM_IIMAGE_BUFFER = GL_INT_IMAGE_BUFFER_EXT,

    LUXGL_PARAM_UIMAGE_1D = GL_UNSIGNED_INT_IMAGE_1D_EXT,
    LUXGL_PARAM_UIMAGE_2D = GL_UNSIGNED_INT_IMAGE_2D_EXT,
    LUXGL_PARAM_UIMAGE_3D = GL_UNSIGNED_INT_IMAGE_3D_EXT,
    LUXGL_PARAM_UIMAGE_CUBE = GL_UNSIGNED_INT_IMAGE_CUBE_EXT,
    LUXGL_PARAM_UIMAGE_2DRECT = GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT,
    LUXGL_PARAM_UIMAGE_2DMS = GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT,
    LUXGL_PARAM_UIMAGE_1DARRAY = GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT,
    LUXGL_PARAM_UIMAGE_2DARRAY = GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT,
    LUXGL_PARAM_UIMAGE_CUBEARRAY = GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT,
    LUXGL_PARAM_UIMAGE_2DMSARRAY = GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT,
    LUXGL_PARAM_UIMAGE_BUFFER = GL_UNSIGNED_INT_IMAGE_BUFFER_EXT,

    LUXGL_PARAM_BUFFER = 0xABCDEF,
  }lxGLParameterType_t;
  
/// __LUXLUXGL_BUFFER_H__
  
    typedef enum lxgBufferMode_e{
    LUXGFX_BUFFERMODE_DRAW,
    LUXGFX_BUFFERMODE_READ,
    LUXGFX_BUFFERMODE_COPY,
    LUXGFX_BUFFERMODES,
  }lxgBufferMode_t;

  typedef enum lxgBufferUpdate_e{
    LUXGFX_BUFFERUPDATE_STATIC,
    LUXGFX_BUFFERUPDATE_DYNAMIC,
    LUXGFX_BUFFERUPDATE_STREAM,
    LUXGFX_BUFFERUPDATES,
  }lxgBufferUpdate_t;

  typedef struct lxgBuffer_s{
    lxGLBufferTarget_t    gltarget;
    GLuint                glid;
    GLuint64              address;
    lxgContextPTR         ctx;
    void*                 user;

    void*                 mapped;
    lxgAccessMode_t       maptype;
    uint                  mapstart;
    uint                  maplength;
        
    uint                  size;
    uint                  used;
    lxgBufferMode_t       mode;
    lxgBufferUpdate_t     update;
  }lxgBuffer_t;


  // raises used and returns offset withn padsize from start or -1 on error
   uint lxgBuffer_alloc(lxgBufferPTR buffer, uint needed, uint padsize);

   void lxgBuffer_bind(lxgBufferPTR buffer, lxGLBufferTarget_t type);
   void lxgBuffer_bindIndexed(lxgBufferPTR buffer, lxGLBufferTarget_t type, uint idx);
   void lxgBuffer_bindRanged(lxgBufferPTR buffer, lxGLBufferTarget_t type, uint idx, size_t offset, size_t size);

  // implicitly call lxgBuffer_setGL with type used on init
   booln lxgBuffer_map(lxgBufferPTR buffer, void**ptr, lxgAccessMode_t type);
   booln lxgBuffer_mapRange(lxgBufferPTR buffer, void**ptr, uint from, uint length, lxgAccessMode_t type, booln manualflush, booln unsynch);
   booln lxgBuffer_flushRange(lxgBufferPTR buffer, uint from, uint length);
   booln lxgBuffer_unmap(lxgBufferPTR buffer);
   booln lxgBuffer_copy(lxgBufferPTR buffer, uint bufferoffset, lxgBufferPTR src, uint srcoffset, uint size);

   GLuint64 lxgBuffer_addressNV(lxgBufferPTR buffer);
   void lxgBuffer_residentNV(lxgBufferPTR buffer, lxgAccessMode_t mode);
   void lxgBuffer_unresidentNV(lxgBufferPTR buffer);

   void lxgBuffer_deinit(lxgBufferPTR buffer, lxgContextPTR ctx);
   void lxgBuffer_reset(lxgBufferPTR buffer, void* data);
   void lxgBuffer_init(lxgBufferPTR buffer, lxgContextPTR ctx, lxgBufferMode_t hint, lxgBufferUpdate_t update, uint size, void* data);

/// __LUXLUXGFX_VERTEX_H__
  
  //////////////////////////////////////////////////////////////////////////
  // VertexAttrib

  typedef enum lxgVertexAttrib_e{
    LUXGFX_VERTEX_ATTRIB_POS,
    LUXGFX_VERTEX_ATTRIB_ATTR1,   // Cg:  blendweights
    LUXGFX_VERTEX_ATTRIB_NORMAL,
    LUXGFX_VERTEX_ATTRIB_COLOR,
    LUXGFX_VERTEX_ATTRIB_ATTR4,
    LUXGFX_VERTEX_ATTRIB_ATTR5,   // Cg: fogcoord,tessfactor
    LUXGFX_VERTEX_ATTRIB_ATTR6,   // Cg: pointsize
    LUXGFX_VERTEX_ATTRIB_ATTR7,   // Cg: blendindices 
    LUXGFX_VERTEX_ATTRIB_TEXCOORD0,
    LUXGFX_VERTEX_ATTRIB_TEXCOORD1,
    LUXGFX_VERTEX_ATTRIB_TEXCOORD2,
    LUXGFX_VERTEX_ATTRIB_TEXCOORD3,
    LUXGFX_VERTEX_ATTRIB_ATTR12,
    LUXGFX_VERTEX_ATTRIB_ATTR13,
    LUXGFX_VERTEX_ATTRIB_ATTR14,    // Cg: tangent
    LUXGFX_VERTEX_ATTRIB_ATTR15,    // Cg: binormal
    LUXGFX_VERTEX_ATTRIBS,
  }lxgVertexAttrib_t;

  //////////////////////////////////////////////////////////////////////////
  // lxgVertexElement_t
  //
  // assumes maximum vertex size of 256 bytes, and stride as multiple of 2

  typedef struct lxgVertexElement_s{
    unsigned  normalize :  1;
    unsigned  integer :  1;
    unsigned  cnt  :     2;
    unsigned  stream :     4;
    unsigned  scalartype : 8;
    unsigned  stridehalf : 8;
    unsigned  offset :  8;
  }lxgVertexElement_t;

  //////////////////////////////////////////////////////////////////////////
  // lxgVertexPointer

  typedef struct lxgVertexDecl_s{
    flags32               available;
    uint                  streams;
    lxgVertexElement_t    table[LUXGFX_VERTEX_ATTRIBS];
  }lxgVertexDecl_t;

  //////////////////////////////////////////////////////////////////////////
  // lxgVertexPointer

  typedef struct lxgStreamHost_s{
    lxgBufferPTR        buffer;
    void*               ptr;
    size_t              len;
  }lxgStreamHost_t;
  
  typedef struct lxgVertexPointer_s{
    lxgVertexElement_t  element[LUXGFX_VERTEX_ATTRIBS];
    lxgStreamHost_t     streams[LUXGFX_MAX_VERTEX_STREAMS];
  }lxgVertexPointer_t;

  typedef struct lxgVertexState_s{
    lxgVertexDeclPTR    decl;
    flags32             active;
    flags32             declvalid;
    flags32             streamvalid;
    flags32             declchange;
    flags32             streamchange;

    lxgVertexPointer_t  setup;
  }lxgVertexState_t;

  typedef struct lxgFeedbackState_s{
    lxGLPrimitiveType_t capture;
    int                 active;
    flags32             usedvalid;
    flags32             streamvalid;
    flags32             streamchange;
    
    lxgStreamHost_t     streams[LUXGFX_MAX_VERTEX_STREAMS];
  }lxgFeedbackState_t;


   lxgVertexElement_t lxgVertexElement_set(
    uint cnt, enum lxScalarType_e type, booln normalize, 
    booln integer, uint stride,uint offset, uint stream);

   void lxgVertexAttribs_apply(flags32 attribs, lxgContextPTR ctx, flags32 changed);
   void lxgVertexAttribs_applyFIXED(flags32 attribs, lxgContextPTR ctx, flags32 changed);
   void lxgVertexAttrib_setFloat(lxgVertexAttrib_t attrib, const float* vec4);
   void lxgVertexAttrib_setInteger(lxgVertexAttrib_t attrib, const int* vec4);
   void lxgVertexAttrib_setFloatFIXED(lxgVertexAttrib_t attrib, const float* vec4);

   void lxgVertexDecl_apply( lxgVertexDeclPTR decl, lxgContextPTR ctx );
   void lxgVertexSetup_setStreams(lxgContextPTR ctx, lxgVertexDeclPTR decl, lxgStreamHostPTR hosts);
   void lxgVertexSetup_setStream(lxgContextPTR ctx, uint idx, lxgStreamHostPTR host);
   void lxgVertexSetup_apply(lxgContextPTR ctx);
   void lxgVertexSetup_applyFIXED(lxgContextPTR ctx);
   void lxgVertexSetup_applyNV(lxgContextPTR ctx);
   void lxgVertexSetup_applyFIXEDNV(lxgContextPTR ctx);

   void lxgFeedback_enable(lxgContextPTR ctx, lxGLPrimitiveType_t type, int numStreams);
   void lxgFeedback_disable(lxgContextPTR ctx);
   void lxgFeedback_pause(lxgContextPTR ctx);
   void lxgFeedback_resume(lxgContextPTR ctx);

   void lxgFeedback_applyStreams(lxgContextPTR ctx);
   void lxgFeedback_setStreams(lxgContextPTR ctx, lxgStreamHostPTR hosts, int numStreams);
   void lxgFeedback_setStream(lxgContextPTR ctx, uint idx, lxgStreamHostPTR host );

/// __LUXLUXGFX_TEXTURE_H__

  typedef enum lxgSamplerFilter_e{
    LUXGFX_SAMPLERFILTER_NEAREST,
    LUXGFX_SAMPLERFILTER_LINEAR,
    LUXGFX_SAMPLERFILTER_MIPMAP_NEAREST,
    LUXGFX_SAMPLERFILTER_MIPMAP_LINEAR,

    LUXGFX_SAMPLERFILTERS,
  }lxgSamplerFilter_t;

  typedef enum lxgSamplerAddress_e{
    LUXGFX_SAMPLERADDRESS_REPEAT,
    LUXGFX_SAMPLERADDRESS_MIRROR,
    LUXGFX_SAMPLERADDRESS_CLAMP,
    LUXGFX_SAMPLERADDRESS_BORDER,

    LUXGFX_SAMPLERADDRESSES,
  }lxgSamplerAddress_t;

  enum lxgSamplerAttrib_e{
    LUXGFX_SAMPLERATTRIB_FILTER = 1<<0,
    LUXGFX_SAMPLERATTRIB_CMP = 1<<1,
    LUXGFX_SAMPLERATTRIB_ADDRESS = 1<<2,
    LUXGFX_SAMPLERATTRIB_ANISO = 1<<3,
    LUXGFX_SAMPLERATTRIB_LOD = 1<<4,
    LUXGFX_SAMPLERATTRIB_BORDER = 1<<5,
    LUXGFX_SAMPLERATTRIB_ALL = (1<<6)-1,
  };

  typedef struct lxgSamplerLod_s{
    float         bias;
    float         min;
    float         max;
  }lxgSamplerLod_t;

  typedef struct lxgSampler_s{
    GLuint                glid;
    uint32                incarnation;
    lxGLCompareMode_t     cmpfunc;
    lxgSamplerFilter_t    filter;
    lxgSamplerAddress_t   addru;
    lxgSamplerAddress_t   addrv;
    lxgSamplerAddress_t   addrw;
    uint                  aniso;
    lxgSamplerLod_t       lod;

    float                 border[4];
  }lxgSampler_t;

  //////////////////////////////////////////////////////////////////////////

  typedef enum lxgTextureFlags_e{
    LUXGFX_TEXTUREFLAG_AUTOMIPMAP = 1<<0,
    LUXGFX_TEXTUREFLAG_MANMIPMAP  = 1<<1,
    LUXGFX_TEXTUREFLAG_COMPRESS   = 1<<2,
    LUXGFX_TEXTUREFLAG_COMPRESSED = 1<<3,
    LUXGFX_TEXTUREFLAG_SAMPLESFIXED = 1<<4,

    LUXGFX_TEXTUREFLAG_HASLOD     = 1<<30,
    LUXGFX_TEXTUREFLAG_HASCOMPARE = 1<<31,
  }lxgTextureFlags_t;

  typedef enum lxgTextureChannel_e{
    LUXGFX_TEXTURECHANNEL_RGB,
    LUXGFX_TEXTURECHANNEL_RGBA,
  
    LUXGFX_TEXTURECHANNEL_R,
    LUXGFX_TEXTURECHANNEL_RG,

    LUXGFX_TEXTURECHANNEL_SRGB,
    LUXGFX_TEXTURECHANNEL_SRGBA,

    LUXGFX_TEXTURECHANNEL_DEPTH,
    LUXGFX_TEXTURECHANNEL_DEPTHSTENCIL,

    LUXGFX_TEXTURECHANNEL_ALPHA,
    LUXGFX_TEXTURECHANNEL_INTENSITY,
    LUXGFX_TEXTURECHANNEL_LUMINANCE,
    LUXGFX_TEXTURECHANNEL_LUMINANCEALPHA,

    LUXGFX_TEXTURECHANNEL_CUSTOM,
  }lxgTextureChannel_t;

  typedef enum lxgTextureDataType_e{
    LUXGFX_TEXTUREDATA_BASE,

    LUXGFX_TEXTUREDATA_UNORM8,
    LUXGFX_TEXTUREDATA_UNORM16,
    LUXGFX_TEXTUREDATA_SNORM8,
    LUXGFX_TEXTUREDATA_SNORM16,
    
    LUXGFX_TEXTUREDATA_FLOAT16,
    LUXGFX_TEXTUREDATA_FLOAT32,

    LUXGFX_TEXTUREDATA_SINT8,
    LUXGFX_TEXTUREDATA_UINT8,
    LUXGFX_TEXTUREDATA_SINT16,
    LUXGFX_TEXTUREDATA_UINT16,
    LUXGFX_TEXTUREDATA_SINT32,
    LUXGFX_TEXTUREDATA_UINT32,

    LUXGFX_TEXTUREDATAS,

    // for depth
    LUXGFX_TEXTUREDATA_DEPTH16,
    LUXGFX_TEXTUREDATA_DEPTH24,
    LUXGFX_TEXTUREDATA_DEPTH32,
    LUXGFX_TEXTUREDATA_DEPTH32F,
    // for RGBA
    LUXGFX_TEXTUREDATA_UNORM1010102,
    LUXGFX_TEXTUREDATA_UINT1010102,
    LUXGFX_TEXTUREDATA_FLOAT111110,
    // for RGB
    LUXGFX_TEXTUREDATA_EXP999,

    LUXGFX_TEXTUREDATA_COMPRESSED,
    LUXGFX_TEXTUREDATA_COMPRESSED_DXT1,
    LUXGFX_TEXTUREDATA_COMPRESSED_DXT3,
    LUXGFX_TEXTUREDATA_COMPRESSED_DXT5,
    LUXGFX_TEXTUREDATA_COMPRESSED_TC,
    LUXGFX_TEXTUREDATA_COMPRESSED_SIGNED_TC,
    LUXGFX_TEXTUREDATA_COMPRESSED_UNORM_BPTC,
    LUXGFX_TEXTUREDATA_COMPRESSED_FLOAT_BPTC,
    LUXGFX_TEXTUREDATA_COMPRESSED_SIGNED_FLOAT_BPTC,
    LUXGFX_TEXTUREDATA_CUSTOM,
  }lxgTextureDataType_t;

  typedef struct lxgTexture_s{
    lxGLTextureTarget_t   gltarget;
    GLuint                glid;
    lxgSamplerPTR         lastSampler;
    uint32                lastSamplerIncarnation;
    lxgContextPTR         ctx;

    lxgTextureChannel_t   formattype;
    lxgTextureDataType_t  datatype;
    flags32               flags;

    int           width;
    int           height;
    int           depth;
    int           arraysize;
    int           samples;

    flags32       mipsdefined;
    uint          miplevels;
    lxVec3i_t     mipsizes[LUXGFX_MAX_TEXTURE_MIPMAPS];
    uint          pixelsizes[LUXGFX_MAX_TEXTURE_MIPMAPS];
    size_t        nativesizes[LUXGFX_MAX_TEXTURE_MIPMAPS];

    uint          components;
    uint          componentsize;

    lxgSampler_t  sampler;
    GLenum        glinternalformat;
    GLenum        gldatatype;
    GLenum        gldataformat;
  }lxgTexture_t;

  typedef struct lxgRenderBuffer_s{
    GLuint                glid;
    lxgContextPTR         ctx;

    lxgTextureChannel_t formattype;
    int           width;
    int           height;
    uint          samples;
  }lxgRenderBuffer_t;
  

    // for cubemap: z == side 
    // for cubemap array: layer = z/6, side = z%6)
  typedef struct lxgTextureUpdate_s{
    lxVec3i_t   from;
    lxVec3i_t   to;
    lxVec3i_t   size;
  }lxgTextureUpdate_t;

  //////////////////////////////////////////////////////////////////////////

  typedef struct lxgTextureImage_s{
    lxgTexturePTR     tex;
    int               level;
    booln             layered;
    int               layer;
    GLenum            glformat;
    GLenum            glaccess;
  }lxgTextureImage_t;

  //////////////////////////////////////////////////////////////////////////
  

  // Type checks
   booln lxgTextureChannel_valid(lxgContextPTR ctx, lxgTextureChannel_t channel);
   booln lxgTextureTarget_valid(lxgContextPTR ctx, lxGLTextureTarget_t type);
  
  // lxgTexture

   // for multisampled textures depth = samples
   void lxgTexture_init(lxgTexturePTR tex, lxgContextPTR ctx);
   booln lxgTexture_setup(lxgTexturePTR tex, 
    lxGLTextureTarget_t type, lxgTextureChannel_t format, lxgTextureDataType_t data,
    int width, int height, int depth, int arraysize, flags32 flags);

   booln lxgTexture_resize(lxgTexturePTR tex, 
    int width, int height, int depth, int arraysize);

   void  lxgTexture_deinit(lxgTexturePTR tex, lxgContextPTR ctx);
  
   booln lxgTexture_readFrame(lxgTexturePTR tex, lxgContextPTR ctx, 
    const lxgTextureUpdatePTR update, uint miplevel);

    // if scalartype is set to invalid, we assume "native" data (matching
    // internal)
   booln lxgTexture_readData(lxgTexturePTR tex, 
    const lxgTextureUpdatePTR update, uint miplevel,
    enum lxScalarType_e scalar, const void* buffer, uint buffersize);

   booln lxgTexture_readBuffer(lxgTexturePTR tex, 
    const lxgTextureUpdatePTR update, uint miplevel,
    enum lxScalarType_e scalar, const lxgBufferPTR buffer, uint bufferoffset);

   booln lxgTexture_writeData(lxgTexturePTR tex, uint side, booln ascompressed, booln onlydepth, uint mip, enum lxScalarType_e d, void* buffer, uint buffersize);
   booln lxgTexture_writeBuffer(lxgTexturePTR tex, uint side, booln ascompressed, booln onlydepth, uint mip, enum lxScalarType_e d, lxgBufferPTR buffer, uint bufferoffset);

   void  lxgTexture_getSampler(lxgTexturePTR tex, lxgSamplerPTR sampler);
   const lxVec3iPTR  lxgTexture_getMipSize(lxgTexturePTR tex, uint mipLevel);
  
   void  lxgTextureUnit_setCompare(lxgContextPTR ctx, uint imageunit, enum lxgCompareMode_e cmp);
   void  lxgTextureUnit_setSampler(lxgContextPTR ctx, uint imageunit, lxgSamplerPTR sampler, flags32 what);
   void  lxgTextureUnit_checkedSampler(lxgContextPTR ctx, uint imageunit, lxgSamplerPTR sampler, flags32 what);

  //////////////////////////////////////////////////////////////////////////
  // lxgSampler_t

   void lxgSampler_init(lxgSamplerPTR self);
   void lxgSampler_setAddress(lxgSamplerPTR self, uint n, lxgSamplerAddress_t address);
   void lxgSampler_setCompare(lxgSamplerPTR self, enum lxgCompareMode_e cmp);
   void lxgSampler_changed(lxgSamplerPTR self);
  
    // require SM4
   void lxgSampler_initHW(lxgSamplerPTR self, lxgContextPTR ctx);
   void lxgSampler_deinitHW(lxgSamplerPTR self, lxgContextPTR ctx);
   void lxgSampler_updateHW(lxgSamplerPTR self, lxgContextPTR ctx);
  
  //////////////////////////////////////////////////////////////////////////
  // lxgRenderBuffer

   booln lxgRenderBuffer_init(lxgRenderBufferPTR rb, lxgContextPTR ctx, lxgTextureChannel_t format,
    int width, int height, int samples);

   booln lxgRenderBuffer_change(lxgRenderBufferPTR rb,
    lxgTextureChannel_t format,
    int width, int height, int samples);

   void  lxgRenderBuffer_deinit(lxgRenderBufferPTR rb, lxgContextPTR ctx);

  //////////////////////////////////////////////////////////////////////////
  // lxgTextureImage

   booln lxgTextureImage_init(lxgTextureImagePTR img, lxgContextPTR ctx, lxgTexturePTR tex, lxgAccessMode_t acces, 
    uint level, booln layered, int layer);

/// __LUXLUXGFX_RENDERTARGET_H__

  typedef struct lxgFrameBounds_s{
    int               width;
    int               height;
  }lxgFrameBounds_t;

  typedef struct lxgViewDepth_s{
    double            near;
    double            far;
  }lxgViewDepth_t;

  typedef struct lxgViewPort_s{
    booln             scissor;
    lxRectanglei_t    scissorRect;
    lxRectanglei_t    viewRect;
    lxgViewDepth_t  depth;
  }lxgViewPort_t;

  typedef struct lxgViewPortMrt_s{
    uint              numused;
    flags32           scissored;

    lxRectanglef_t    bounds[LUXGFX_MAX_RENDERTARGETS];
    lxRectanglei_t    scissors[LUXGFX_MAX_RENDERTARGETS];
    lxgViewDepth_t    depths[LUXGFX_MAX_RENDERTARGETS];
  }lxgViewPortMrt_t;

  typedef enum lxgRenderTargetType_e{
    LUXGFX_RENDERTARGET_DRAW,
    LUXGFX_RENDERTARGET_READ,
    LUXGFX_RENDERTARGETS
  }lxgRenderTargetType_t;

  typedef struct lxgRenderAssign_s{
    lxgTexturePTR       tex;
    lxgRenderBufferPTR  rbuf;
    uint                  mip;
    uint                  layer;
  }lxgRenderAssign_t;

  typedef enum lxgRenderAssignType_e{
    LUXGFX_RENDERASSIGN_DEPTH,
    LUXGFX_RENDERASSIGN_STENCIL,
    LUXGFX_RENDERASSIGN_COLOR0,
    LUXGFX_RENDERASSIGNS = LUXGFX_RENDERASSIGN_COLOR0 + LUXGFX_MAX_RENDERTARGETS,
  }lxgRenderAssignType_t;

  typedef struct lxgRenderTarget_s{
    GLuint              glid;
    lxgContextPTR       ctx;

    uint                maxidx;
    flags32             dirty;
        
    lxgRenderAssign_t   assigns[LUXGFX_RENDERASSIGNS];

    booln               equalsized;
    lxgFrameBounds_t    bounds;
  }lxgRenderTarget_t;

  typedef struct lxgRenderTargetBlit_s{
    lxVec2i_t           fromStart;
    lxVec2i_t           fromEnd;
    lxVec2i_t           toStart;
    lxVec2i_t           toEnd;
  }lxgRenderTargetBlit_t;
  typedef struct lxgRenderTargetBlit_s* lxgRenderTargetBlitPTR;

   void lxgRenderTarget_init(lxgRenderTargetPTR rt, lxgContextPTR ctx);
   void lxgRenderTarget_deinit(lxgRenderTargetPTR rt, lxgContextPTR ctx);

   void lxgRenderTarget_applyAssigns(lxgRenderTargetPTR rt, lxgRenderTargetType_t mode);


  // to and from may be NULL
   void lxgRenderTarget_applyBlit(lxgRenderTargetPTR to, lxgContextPTR ctx, lxgRenderTargetPTR from, lxgRenderTargetBlitPTR update, flags32 mask, booln linearFilter);

   void lxgRenderTarget_setAssign(lxgRenderTargetPTR rt, uint assigntype, lxgRenderAssignPTR assign);
   booln lxgRenderTarget_checkSize(lxgRenderTargetPTR rt);
   const lxgFrameBoundsPTR lxgRenderTarget_getBounds(lxgRenderTargetPTR rt);


  // return the actual scissor state (can be enabled indirectly through viewport != framebounds)
   booln lxgViewPortRect_apply(lxRectangleiPTR rect, lxgContextPTR ctx);
   booln lxgViewPortScissor_applyState(booln state, lxgContextPTR ctx);
   booln lxgViewPort_apply(lxgViewPortPTR obj, lxgContextPTR ctx);
   void  lxgViewPort_sync(lxgViewPortPTR obj, lxgContextPTR ctx);

   void  lxgViewPortMrt_apply(lxgViewPortMrtPTR obj, lxgContextPTR ctx);
   void  lxgViewPortMrt_sync(lxgViewPortMrtPTR obj, lxgContextPTR ctx);

/// __LUXLUXGFX_STATE_H__

  typedef enum lxgWinding_e{
    LUXGFX_WIND_CCW,
    LUXGFX_WIND_CW,
  }lxgWinding_t;

  typedef struct lxgRasterizer_s{
    lxgWinding_t    wind;

    booln       multisample;
    booln       fill;
    booln       depthclamp;

    float       polyoffset;
    float       polyoffsetslope;
  }lxgRasterizer_t;

  //////////////////////////////////////////////////////////////////////////

  typedef struct lxgAlpha_s{
    lxGLCompareMode_t    func;
    float               refval;
  }lxgAlpha_t;

  typedef struct lxgDepth_s{
    lxGLCompareMode_t    func;
    booln               clip;
  }lxgDepth_t;

  //////////////////////////////////////////////////////////////////////////
  typedef struct lxgLogic_s{
    lxGLLogicOp_t      op;
  }lxgLogic_t;

  //////////////////////////////////////////////////////////////////////////

  typedef struct lxgStencilOp_s
  {
    lxGLStencilMode_t  fail;
    lxGLStencilMode_t  zfail;
    lxGLStencilMode_t  zpass;
    lxGLCompareMode_t  func;
  }lxgStencilOp_t;

  typedef struct lxgStencil_s{
    uint16      refvalue;
    uint16      mask;

    lxgStencilOp_t  ops[2]; // 0 = front 1 = back
  }lxgStencil_t;

  //////////////////////////////////////////////////////////////////////////

  typedef struct lxgBlendMode_s{
    lxGLBlendWeight_t srcw;
    lxGLBlendWeight_t dstw;
    lxGLBlendEquation_t equ;
  }lxgBlendMode_t;

  typedef struct lxgBlend_s{
    lxgBlendMode_t    colormode;
    lxgBlendMode_t    alphamode;
  }lxgBlend_t;

  typedef struct lxgBlendMrt_s{
    uint16          individual;
    uint16          numused;
    flags32         enabled;
    lxgBlend_t      blends[LUXGFX_MAX_RENDERTARGETS];
  }lxgBlendMrt_t;

  //////////////////////////////////////////////////////////////////////////

  enum lxgRenderFlag_e {
    LUXGFX_RFLAG_STENCILWRITE1 = 1<<0,
    LUXGFX_RFLAG_STENCILWRITE2 = 1<<1,
    LUXGFX_RFLAG_STENCILWRITE3 = 1<<2,
    LUXGFX_RFLAG_STENCILWRITE4 = 1<<3,
    LUXGFX_RFLAG_STENCILWRITE5 = 1<<4,
    LUXGFX_RFLAG_STENCILWRITE6 = 1<<5,
    LUXGFX_RFLAG_STENCILWRITE7 = 1<<6,
    LUXGFX_RFLAG_STENCILWRITE8 = 1<<7,
    LUXGFX_RFLAG_STENCILWRITE = LUXGFX_RFLAG_STENCILWRITE1 |
                                LUXGFX_RFLAG_STENCILWRITE2 |
                                LUXGFX_RFLAG_STENCILWRITE3 |
                                LUXGFX_RFLAG_STENCILWRITE4 |
                                LUXGFX_RFLAG_STENCILWRITE5 |
                                LUXGFX_RFLAG_STENCILWRITE6 |
                                LUXGFX_RFLAG_STENCILWRITE7 |
                                LUXGFX_RFLAG_STENCILWRITE8,
    LUXGFX_RFLAG_FRONTCULL  =    1<<8,
    LUXGFX_RFLAG_DEPTHWRITE =    1<<9,
    LUXGFX_RFLAG_CCW =          1<<10,
    LUXGFX_RFLAG_CULL =         1<<11,
    LUXGFX_RFLAG_COLORWRITER =  1<<12,
    LUXGFX_RFLAG_COLORWRITEG =  1<<13,
    LUXGFX_RFLAG_COLORWRITEB =  1<<14,
    LUXGFX_RFLAG_COLORWRITEA =  1<<15,
    LUXGFX_RFLAG_COLORWRITE =   LUXGFX_RFLAG_COLORWRITER |
                                LUXGFX_RFLAG_COLORWRITEG |
                                LUXGFX_RFLAG_COLORWRITEB |
                                LUXGFX_RFLAG_COLORWRITEA,
    LUXGFX_RFLAG_BLEND =        1<<16,
    LUXGFX_RFLAG_STENCILTEST =  1<<17,
    LUXGFX_RFLAG_LOGIC =        1<<18,
    LUXGFX_RFLAG_DEPTHTEST =    1<<19,
    LUXGFX_RFLAG_WIRE =         1<<20,
  };

  //////////////////////////////////////////////////////////////////////////


   void  lxgDepth_init(lxgDepthPTR obj);
   void  lxgDepth_apply(lxgDepthPTR obj, lxgContextPTR ctx);
   void  lxgDepth_sync(lxgDepthPTR obj, lxgContextPTR ctx);

   void  lxgLogic_init(lxgLogicPTR obj);
   void  lxgLogic_apply(lxgLogicPTR obj, lxgContextPTR ctx);
   void  lxgLogic_sync(lxgLogicPTR obj, lxgContextPTR ctx);

   void  lxgStencil_init(lxgStencilPTR obj);
   void  lxgStencil_apply(lxgStencilPTR obj, lxgContextPTR ctx);
   void  lxgStencil_sync(lxgStencilPTR obj, lxgContextPTR ctx);

   void  lxgBlend_init(lxgBlendPTR obj);
   void  lxgBlend_apply(lxgBlendPTR obj, lxgContextPTR ctx);
   void  lxgBlend_sync(lxgBlendPTR obj, lxgContextPTR ctx);

   void  lxgBlendMrt_apply(lxgBlendMrtPTR obj, lxgContextPTR ctx);
   void  lxgBlendMrt_sync(lxgBlendMrtPTR obj, lxgContextPTR ctx);

   flags32 lxgRenderFlag_init();
   flags32 lxgRenderFlag_sync(lxgContextPTR ctx);
   void    lxgRenderFlag_apply(flags32 flags, lxgContextPTR ctx, flags32 changed);
   const char* lxgRenderFlag_test(lxgContextPTR ctx);

   void lxgRasterizer_sync(lxgRasterizerPTR raster, lxgContextPTR ctx);

  typedef enum lxgProgramType_e{
    LUXGFX_PROGRAM_NONE,
    LUXGFX_PROGRAM_GLSL,
    LUXGFX_PROGRAM_ARBNV,
  }lxgProgramType_t;

  typedef enum lxgShaderDomain_e{
    LUXGFX_DOMAIN_VERTEX,
    LUXGFX_DOMAIN_FRAGMENT,
    LUXGFX_DOMAIN_GEOMETRY,
    LUXGFX_DOMAIN_TESSCTRL,
    LUXGFX_DOMAIN_TESSEVAL,
    LUXGFX_DOMAINS,
  }lxgProgramDomain_t;

  typedef void (*lxgParmeterUpdate_fn)(lxgContextPTR ctx, lxgProgramParameterPTR param, void* data);

  typedef struct lxgProgramParameter_s{
    lxGLParameterType_t   gltype;
    union{
      GLuint              glid;
      GLenum              gltarget;
    };
    GLuint                gllocation;
    lxgParmeterUpdate_fn  func;
    ushort                count;
    bool16                transpose;
    uint                  size;
    const char*           name;
  }lxgProgramParameter_t;

  typedef struct lxgProgramData_s{
    uint                      numParams;
    lxgProgramParameterPTR    parameters;
    uint                      numSampler;
    lxgProgramParameterPTR    samplers;
    uint                      numBuffers;
    lxgProgramParameterPTR    buffer;
    uint                      numImages;
    lxgProgramParameterPTR    images;
  }lxgProgramData_t;

  typedef struct lxgDomainProgram_s{
    union{
      lxGLShaderType_t    gltype;
      lxGLProgramType_t   gltarget;
    };
    GLuint                glid;
    lxgProgramDataPTR     data;
    lxgContextPTR         ctx;
    lxgProgramType_t      progtype;
  }lxgDomainProgram_t;

  typedef struct lxgProgram_s{
    GLuint                glid;
    lxgProgramType_t      type;
    flags32               usedProgs;
    lxgDomainProgramPTR   programs[LUXGFX_DOMAINS];
    lxgProgramDataPTR     data;
    lxgContextPTR         ctx;
  }lxgProgram_t;

  // GLSL
   void lxgProgramParameter_initFunc(lxgProgramParameterPTR param);

   void lxgDomainProgram_init(lxgDomainProgramPTR stage, lxgContextPTR ctx, lxgProgramDomain_t type);
   void lxgDomainProgram_deinit(lxgDomainProgramPTR stage, lxgContextPTR ctx);
   booln lxgDomainProgram_compile(lxgDomainProgramPTR stage, const char *src, int len);
   const char* lxgDomainProgram_error(lxgDomainProgramPTR stage, char *buffer, int len);

   void  lxgProgram_init(lxgProgramPTR prog, lxgContextPTR ctx);
   void  lxgProgram_deinit(lxgProgramPTR prog, lxgContextPTR ctx);
   void  lxgProgram_setDomain(lxgProgramPTR prog, lxgProgramDomain_t type, lxgDomainProgramPTR stage);
   booln lxgProgram_link(lxgProgramPTR prog);
   const char* lxgProgram_log(lxgProgramPTR prog, char* buffer, int len);

  // COMMON
   void lxgProgram_applyParameters(lxgProgramPTR prog, lxgContextPTR ctx, uint num, lxgProgramParameterPTR *params, void **data);
   void lxgProgram_applySamplers( lxgProgramPTR prog, lxgContextPTR ctx, uint num, lxgProgramParameterPTR *params, lxgTexturePTR *data);
   void lxgProgram_applyBuffers(lxgProgramPTR prog, lxgContextPTR ctx, uint num, lxgProgramParameterPTR *params, lxgBufferPTR *data);
   void lxgProgram_applyImages( lxgProgramPTR prog, lxgContextPTR ctx, uint num, lxgProgramParameterPTR *params, lxgTextureImagePTR *data );

  // NV/ARB PROGRAM
   void lxgProgramParameter_initDomainNV(lxgProgramParameterPTR param, lxgProgramDomain_t domain);
   void lxgProgramParameter_initFuncNV(lxgProgramParameterPTR param);

   void lxgDomainProgram_initNV(lxgDomainProgramPTR stage, lxgContextPTR ctx, lxgProgramDomain_t type);
   void lxgDomainProgram_deinitNV(lxgDomainProgramPTR stage, lxgContextPTR ctx);
   booln lxgDomainProgram_compileNV(lxgDomainProgramPTR stage, const char *src, int len);
   const char* lxgDomainProgram_errorNV(lxgDomainProgramPTR stage, char *buffer, int len);

   void  lxgProgram_initNV(lxgProgramPTR prog, lxgContextPTR ctx);
   void  lxgProgram_deinitNV(lxgProgramPTR prog, lxgContextPTR ctx);
   void  lxgProgram_setDomainNV(lxgProgramPTR prog, lxgProgramDomain_t type, lxgDomainProgramPTR stage);

  //////////////////////////////////////////////////////////////////////////
  enum lxgCapability_e{
    LUXGFX_CAP_POINTSPRITE = 1<<0,
    LUXGFX_CAP_STENCILWRAP = 1<<1,
    LUXGFX_CAP_BLENDSEP = 1<<2,
    LUXGFX_CAP_OCCQUERY = 1<<3,

    LUXGFX_CAP_FBO      = 1<<4,     //+DEPTHSTENCIL
    LUXGFX_CAP_FBOMS    = 1<<5,     // blit,ms
    LUXGFX_CAP_DEPTHFLOAT  = 1<<6,

    LUXGFX_CAP_VBO    = 1<<7,
    LUXGFX_CAP_PBO    = 1<<8,
    LUXGFX_CAP_UBO    = 1<<9,

    LUXGFX_CAP_TEX3D = 1<<10,
    LUXGFX_CAP_TEXRECT = 1<<11,
    LUXGFX_CAP_TEXNP2 = 1<<12,
    LUXGFX_CAP_TEXCUBEARRAY = 1<<13,
    LUXGFX_CAP_TEXS3TC = 1<<14,
    LUXGFX_CAP_TEXRGTC = 1<<15,
    LUXGFX_CAP_TEXRW  = 1<<16,

    LUXGFX_CAP_BUFMAPRANGE = 1<<17,
    LUXGFX_CAP_BUFCOPY = 1<<18,

    LUXGFX_CAP_SM0    = 1<<20,    // DOT3,CROSSBAR,CUBE
    LUXGFX_CAP_SM1    = 1<<21,    // VERTEX,SHADOW
    LUXGFX_CAP_SM2    = 1<<22,    // +FRAGMENT
    LUXGFX_CAP_SM2EXT = 1<<23,    // +DRAWBUFFERS,FLOAT,HLSHADERS
    LUXGFX_CAP_SM3    = 1<<24,    // +NV3/ATI_SHADERLOD
    LUXGFX_CAP_SM4    = 1<<25,    //  GL3.3 TEXINT,TEXBUF,TEXARRAY,UBO,FBOMIX
    //  TEXSAMPLER,XFBO,GS,CUBESAMPLE
    LUXGFX_CAP_SM5    = 1<<26,    //  GL4.0 
  };


  //////////////////////////////////////////////////////////////////////////

  typedef enum lxgGPUVendor_e{
    LUXGFX_GPUVENDOR_UNKNOWN,
    LUXGFX_GPUVENDOR_NVIDIA,
    LUXGFX_GPUVENDOR_ATI,
    LUXGFX_GPUVENDOR_INTEL,
  }lxgGPUVendor_t;

  typedef enum lxgGPUDomain_e{
    LUXGFX_GPUDOMAIN_VERTEX,
    LUXGFX_GPUDOMAIN_FRAGMENT,
    LUXGFX_GPUDOMAIN_GEOMETRY,
    LUXGFX_GPUDOMAIN_TESS_EVAL,
    LUXGFX_GPUDOMAIN_TESS_CTRL,
    LUXGFX_GPUDOMAINS,
  }lxgGPUDomain_t;

  typedef enum lxgGPUMode_e{
    LUXGFX_GPUMODE_FIXED,
    LUXGFX_GPUMODE_ASM,
    LUXGFX_GPUMODE_HL,
  }lxgGPUMode_t;


  //////////////////////////////////////////////////////////////////////////
  typedef struct lxgCapabilites_s{
    int     texsize;
    int     texsize3d;
    int     texlayers;
    int     texunits;
    int     teximages;
    int     texcoords;
    int     texvtxunits;
    float   texaniso;
    float   pointsize;
    int     drawbuffers;
    int     viewports;
    int     fbosamples;
  }lxgCapabilites_t;

  typedef struct lxgContext_s{
    flags32             capbits;
    lxgProgramPTR       program;
    lxgVertexState_t    vertex;
    lxgTexturePTR       textures[LUXGFX_MAX_TEXTURE_IMAGES];
    lxgSamplerPTR       samplers[LUXGFX_MAX_TEXTURE_IMAGES];
    lxgRenderTargetPTR  rendertargets[LUXGFX_RENDERTARGETS];
    lxgTextureImagePTR  images[LUXGFX_MAX_RWTEXTURE_IMAGES];
    lxgBufferPTR        uniform[LUXGFX_MAX_UNIFORM_BUFFERS];
    lxgFeedbackState_t  feedback;

    flags32             rflag;
    lxgBlend_t          blend;
    lxgDepth_t          depth;
    lxgStencil_t        stencil;
    lxgLogic_t          logic;
	
    lxgViewPort_t       viewport;
    lxgFrameBounds_t    framebounds;
    lxgFrameBounds_t    window;

    lxgBlendMrt_t       blendMRT;
    lxgViewPortMrt_t    viewportMRT;
    
    lxgCapabilites_t    capabilites;
  }lxgContext_t;

  //////////////////////////////////////////////////////////////////////////
   const char* lxgContext_init(lxgContextPTR ctx);
   void  lxgContext_syncStates(lxgContextPTR ctx);
   booln lxgContext_checkStates(lxgContextPTR ctx);
   void  lxgContext_resetTextures(lxgContextPTR ctx);
   void  lxgContext_resetVertexStreams(lxgContextPTR ctx);

   void  lxgTexture_apply(lxgTexturePTR obj, lxgContextPTR ctx, uint imageunit);
   void  lxgSampler_apply(lxgSamplerPTR obj, lxgContextPTR ctx, uint imageunit);
   void  lxgTextures_apply(lxgTexturePTR *texs, lxgContextPTR ctx, uint start, uint num);
   void  lxgSamplers_apply(lxgSamplerPTR *samps, lxgContextPTR ctx, uint start, uint num);
   void  lxgTextureImage_apply(lxgTextureImagePTR obj, lxgContextPTR ctx, uint imageunit);
   void  lxgRenderTarget_apply(lxgRenderTargetPTR obj, lxgContextPTR ctx, lxgRenderTargetType_t type);
   void  lxgRenderTarget_applyDraw(lxgRenderTargetPTR obj, lxgContextPTR ctx, booln setViewport);
   void  lxgProgram_apply(lxgProgramPTR obj, lxgContextPTR ctx );

]]

return ffi.load("luxbackend")