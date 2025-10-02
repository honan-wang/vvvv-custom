const fs = require('fs');

// 读取文件
let content = fs.readFileSync('declaration.js', 'utf8');

// 修复语法错误：为缺少的引号添加引号
content = content.replace(/mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝\?,/g, "mainGoods: '鍖栧伐鍘熸枡銆佸鏂欏埗鍝?',");
console.log('第一个修复完成');

content = content.replace(/mainGoods: '绾虹粐鍝併€侀瀷绫\?,/g, "mainGoods: '绾虹粐鍝併€侀瀷绫?',");
console.log('第二个修复完成');

content = content.replace(/mainGoods: '椋熷搧銆侀ギ鏂\?,/g, "mainGoods: '椋熷搧銆侀ギ鏂?',");
console.log('第三个修复完成');

// 写回文件
fs.writeFileSync('declaration.js', content);

console.log('所有语法错误已修复');