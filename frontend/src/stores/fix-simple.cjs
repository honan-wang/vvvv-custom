const fs = require('fs');

// 读取文件内容
let content = fs.readFileSync('declaration.js', 'utf8');

// 找到并替换有问题的行
const lines = content.split('\n');

// 修复第48行 (索引47)
if (lines[47] && lines[47].includes("鍖栧伐鍘熸枡銆佸鏂欏埗鍝?")) {
  lines[47] = "              mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?',";
  console.log('修复第48行');
}

// 修复第57行 (索引56)
if (lines[56] && lines[56].includes("mainGoods: '绾虹粐鍝併€侀瀷绫?,")) {
  lines[56] = lines[56].replace("mainGoods: '绾虹粐鍝併€侀瀷绫?,", "mainGoods: '绾虹粐鍝併€侀瀷绫?',");
  console.log('修复第57行');
}

// 修复第66行 (索引65)
if (lines[65] && lines[65].includes("mainGoods: '椋熷搧銆侀ギ鏂?,")) {
  lines[65] = lines[65].replace("mainGoods: '椋熷搧銆侀ギ鏂?,", "mainGoods: '椋熷搧銆侀ギ鏂?',");
  console.log('修复第66行');
}

// 写回文件
fs.writeFileSync('declaration.js', lines.join('\n'));
console.log('修复完成');